import { A3API } from "./A3API";

/**
 * Базовый класс для WebUI приложений
 * Предоставляет доступ к функциям A3API и базовую функциональность
 */
export abstract class WebUIContextBase {

    // --- singleton-контекст ---
    private static _currentContext: WebUIContextBase | undefined;

    static getCurrent<T extends WebUIContextBase>(): T | undefined {
        return this._currentContext as T | undefined;
    }
    static clearCurrent() {
        this._currentContext = undefined;
    }

    constructor() {
        (this.constructor as typeof WebUIContextBase)._currentContext = this;
        // Регистрируем методы для вызова платформой
        (window as any)._handleEvent = this._handleEvent.bind(this);
        (window as any)._handleVar = this._handleVar.bind(this);
        (window as any)._handleVarList = this._handleVarList.bind(this);
        (window as any)._handleJS = this._handleJS.bind(this);
        
        (window as any)._readyHandleDataFromPlatform = true;
    }

    // --- Приватные методы для платформы ---
    private _handleEvent(fncname: string, map_args: any) {
        // Вызывает метод по имени, если он есть
        const fn = (this as any)[fncname];
        if (typeof fn === "function") {
            fn.call(this, map_args);
        }
    }

    //TODO добавить обработку синхронизации (например переменная valueTest может иметь обработчик onChange_valueTest)
    private _handleVar(varname: string, varvalue: any) {
        // Обновляет поле по имени
        if (varname in this) {
            (this as any)[varname] = varvalue;
        }
    }

    private _handleVarList(map_vars: Record<string, any>) {
        // Обновляет сразу несколько полей
        for (const key in map_vars) {
            if (key in this) {
                (this as any)[key] = map_vars[key];
            }
        }
    }

    private _handleJS(str_code: string) {
        // Выполняет произвольный JS-код (ОПАСНО, только для доверенного кода)
        // eslint-disable-next-line no-eval
        eval(str_code);
    }

    // --- Публичный метод для отправки колбэка на платформу ---
    public sendCallback(callbackname: string, map_args: any) {
        // Предполагается, что платформа слушает window.postMessage или есть API
        if (typeof (A3API as any).SendAlert === "function") {
            (A3API as any).SendAlert(callbackname, map_args);
        } else {
            window.parent.postMessage({ type: "callback", callbackname, map_args }, "*");
        }
    }

    // --- Базовые методы для работы с A3API ---
    /**
     * Загружает текстуру из файловой системы игры
     * @param texturePath - Путь к текстуре в файловой системе игры
     * @param maxSize - Максимальная ширина текстуры
     * @returns Promise с data-url изображения
     */
    protected async loadTexture(texturePath: string, maxSize: number): Promise<string> {
        return (A3API as any).RequestTexture(texturePath, maxSize);
    }

    /**
     * Загружает файл из файловой системы игры
     * @param filePath - Путь к файлу
     * @returns Promise с содержимым файла
     */
    protected async loadFile(filePath: string): Promise<string> {
        return (A3API as any).RequestFile(filePath);
    }

    /**
     * Загружает и предобрабатывает файл из файловой системы игры
     * @param filePath - Путь к файлу
     * @returns Promise с обработанным содержимым файла
     */
    protected async loadPreprocessedFile(filePath: string): Promise<string> {
        return (A3API as any).RequestPreprocessedFile(filePath);
    }

    /**
     * Показывает alert с указанным содержимым
     * @param content - Текст для отображения
     */
    protected sendAlert(content: string): void {
        (A3API as any).SendAlert(content);
    }

    /**
     * Показывает confirm диалог
     * @param content - Текст для отображения
     * @returns Promise с результатом (обычно "OK" или "Cancel")
     */
    protected async sendConfirm(content: string): Promise<string> {
        return (A3API as any).SendConfirm(content);
    }

    /**
     * Абстрактный метод для инициализации UI
     * Должен быть реализован в наследниках
     */
    abstract initialize(): void;

    /**
     * Абстрактный метод для очистки ресурсов
     * Должен быть реализован в наследниках
     */
    abstract cleanup(): void;

}

/**
 * Инициализация контекста (singleton)
 * @param constructor - Конструктор класса, наследующего от HtmlUIContextBase
 * @returns Promise с экземпляром контекста
 */
export async function initContext<T extends WebUIContextBase>(constructor: new () => T): Promise<T> {
    // Проверяем, есть ли уже контекст
    const existing = (constructor as any).getCurrent?.() as T | undefined;
    if (existing) return existing;
    const instance = new constructor();
    await instance.initialize();
    // Автоматическая очистка при закрытии страницы
    window.addEventListener('beforeunload', () => {
        instance.cleanup();
        (constructor as any).clearCurrent?.();
    });
    return instance;
}

enum PlatformEventType {
    Event = "e",
    Var = "v",
    VarList = "vl",
    JS = "c"
}

(window as any).handleEvent = function(evt: PlatformEventType, data: any) {
	try {
		let thisWin = (window as any);
		if (thisWin._readyHandleDataFromPlatform === true) {
			// Система готова — обработка сразу
			switch (evt) {
				case PlatformEventType.Event:
					thisWin._handleEvent(data.name, data.args);
					break;
				case PlatformEventType.Var:
					thisWin._handleVar(data.name, data.value);
					break;
				case PlatformEventType.VarList:
					thisWin._handleVarList(data);
					break;
				case PlatformEventType.JS:
					thisWin._handleJS(data);
					break;
			}
		} else {
			// Система не готова — ждем асинхронно и повторяем вызов
			__waitForPlatformReady().then(() => {
				(window as any).handleEvent(evt, data);
			});
		}
	} catch (error) {
		console.error(error);
	}
}

async function __waitForPlatformReady(): Promise<void> {
    while (!(window as any)._readyHandleDataFromPlatform) {
        await new Promise(resolve => setTimeout(resolve, 50));
    }
}

// Глобальный обработчик необработанных ошибок
window.onerror = function(message, source, lineno, colno, error) {
    console.error("Необработанная ошибка:", { message, source, lineno, colno, error });
    if (typeof (A3API as any).SendError === "function") {
        (A3API as any).sendCallback("!onError", {
            type: "error",
            message,
            source,
            lineno,
            colno,
            error: error ? error.stack || error.toString() : undefined
        });
    }
    // Можно добавить alert или другую обработку
    return false; // false — чтобы ошибка также отображалась в консоли браузера
};

// Глобальный обработчик необработанных promise rejection
window.onunhandledrejection = function(event) {
    console.error("Необработанный rejection:", event.reason);
    if (typeof (A3API as any).SendError === "function") {
        (A3API as any).sendCallback("!onUnhandledRejection", {
            type: "unhandledrejection",
            reason: event.reason ? (event.reason.stack || event.reason.toString()) : undefined
        });
    }
    // Можно добавить alert или другую обработку
};