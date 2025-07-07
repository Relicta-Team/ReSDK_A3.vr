export declare class A3API
{
	/**
	 * Loads file from game filesystem.
	 *
	 * @param filePath - Path in game filesystem, without leading backslash
	 * @param maxSize - maximum texture width (used to select Mip)
	 * @returns The image as a data-url
	 */
	static RequestTexture(texturePath: string, maxSize: number): Promise<string>;

	/**
	 * Loads file from game filesystem.
	 *
	 * @param filePath - same as loadFile SQF command
	 * @returns The file content
	 */
	static RequestFile(filePath: string): Promise<string>;

	/**
	 * Loads and preprocesses file from game filesystem.
	 *
	 * @param filePath - same as preprocessFile SQF command
	 * @returns The file content
	 */
	static RequestPreprocessedFile(filePath: string): Promise<string>;

	// Triggers a alert() (Needs to be piped due to https://chromestatus.com/feature/5148698084376576)
	static SendAlert(content: string): void;

	static SendConfirm(content: string): Promise<string>;
}