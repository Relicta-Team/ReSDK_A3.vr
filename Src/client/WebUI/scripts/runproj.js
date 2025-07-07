/*
  Запуск проекта
*/
const { spawn } = require('child_process');
const readline = require('readline');
const fs = require('fs');
const path = require('path');
const { colorize, colors } = require('./util');
const workDir = path.resolve(path.join(__dirname, '..'));


// Парсим аргументы
let proj, mode;

if (process.env.npm_config_proj) {
	proj = process.env.npm_config_proj;
}
if (process.env.npm_config_mode) {
	mode = process.env.npm_config_mode;
}
const args = [proj, mode];


console.log(colorize("Start runner", colors.green));
console.log(colorize("Context:" + (args.length > 0 ? args.join(' ') : "empty"), colors.yellow));

function run(proj, mode) {
	
	const projectDir = path.join(workDir, 'projects', proj);
	if (!fs.existsSync(projectDir)) {
		console.error(colorize(`Project ${proj} not found`, colors.red));
		process.exit(1);
	}
	if (!fs.existsSync(path.join(projectDir, 'tsconfig.json'))) {
		console.error(colorize(`tsconfig.json not found in ${projectDir}`, colors.red));
		process.exit(1);
	}

  if (mode === 'ts') {
	const entryFile = path.join(projectDir, 'index.ts');
	if (!fs.existsSync(entryFile)) {
		console.error(colorize(`Entry file ${entryFile} not found`, colors.red));
		process.exit(1);
	}
    // Запуск через ts-node
    const tsNodeArgs = [
      '-r', 'tsconfig-paths/register',
      entryFile
    ];
    const child = spawn('npx', ['ts-node', ...tsNodeArgs], { stdio: 'inherit', shell: true });
    child.on('exit', code => process.exit(code));
  } else if (mode === 'serve') {
    // Запуск через webpack-dev-server
    const webpackArgs = [
      'serve',
      '--env', `proj=${proj}`,
      '--env', 'mode=development'
    ];
    const child = spawn('npx', ['webpack', ...webpackArgs], { stdio: 'inherit', shell: true });
    child.on('exit', code => process.exit(code));
  } else {
    console.error(colorize(`Unknown mode: ${mode}`, colors.red));
    process.exit(1);
  }
}

if (!proj || !mode) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });
  rl.question('Enter project name (proj): ', (projAnswer) => {
    proj = proj || projAnswer;
    rl.question('Enter mode (ts/serve): ', (modeAnswer) => {
      mode = mode || modeAnswer;
      rl.close();
      if (!proj || !mode) {
        console.error('Usage: npm run runproj -- --proj=projName --mode=ts|serve');
        process.exit(1);
      }
      run(proj, mode);
    });
  });
} else {
  run(proj, mode);
} 