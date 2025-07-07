/*
  Сборка проекта
*/
const { spawn } = require('child_process');

// Парсим аргументы
const args = process.argv.slice(2);
let proj;
for (const arg of args) {
  if (arg.startsWith('--proj=')) {
    proj = arg.split('=')[1];
  }
}
if (!proj) {
  console.error('Usage: npm run buildproj -- --proj=projName');
  process.exit(1);
}

const webpackArgs = [
  '--env', `proj=${proj}`,
  '--env', 'mode=production'
];

const child = spawn('npx', ['webpack', ...webpackArgs], { stdio: 'inherit', shell: true });
child.on('exit', code => process.exit(code)); 