import { initContext, OnChange, WebUIContextBase } from "./Core";



class ExampleUI extends WebUIContextBase {
    // Пример переменных, которые могут быть обновлены платформой
    @OnChange(()=>{
        ExampleUI.getCurrent<ExampleUI>().testChanger();
    })
    score: number = 0;

    testChanger() {}

    playerName: string = "";

    async initialize(): Promise<void> {
        console.log("Example initialized");
        let x = this.score;
    }

    cleanup(): void {
        console.log("Example cleaned up");
    }

    // Метод для обработки события от платформы
    onStart(args: any) {
        console.log("onStart событие от платформы:", args);
    }

    // Метод для обработки другого события
    onPlayerJoin(args: any) {
        console.log("onPlayerJoin событие от платформы:", args);
    }
}

// Инициализация singleton-контекста
initContext(ExampleUI).then(ctx => {
    console.log("UI запущен", ctx);
    // Демонстрация: платформа может вызвать
    // window._handleEvents("onStart", {foo: 123})
    // window._handleVar("score", 42)
    // window._handleVarList({playerName: "Alice", score: 99})
});

