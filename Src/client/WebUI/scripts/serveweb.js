/*
  Запуск сервера для отладки в браузере
*/
const { spawn } = require('child_process');
const readline = require('readline');
const path = require('path');
const fs = require('fs');

//я так и не смог заставить работать этот вариант...
throw new Error("Not implemented");

// Парсим аргументы
const args = process.argv.slice(2);
let proj;
for (const arg of args) {
  if (arg.startsWith('--proj=')) {
    proj = arg.split('=')[1];
  }
}

function run(proj) {
  const projDir = path.join(__dirname, '..', 'projects', proj);
  if (!fs.existsSync(projDir) || !fs.statSync(projDir).isDirectory()) {
    console.error(`Проект ${proj} не найден!`);
    process.exit(1);
  }
  // Запуск @web/dev-server для папки проекта
  const child = spawn('npx', [
    'web-dev-server',
    '--root-dir', projDir,
    '--open', 'index.html',
    '--watch',
    '--node-resolve',
    '--app-index', 'index.html',
    '--port', '8080'
  ], { stdio: 'inherit', shell: true });
  child.on('exit', code => process.exit(code));
}

if (!proj) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });
  rl.question('Enter project name (proj): ', (projAnswer) => {
    rl.close();
    proj = projAnswer;
    if (!proj) {
      console.error('Usage: npm run serveweb -- --proj=projName');
      process.exit(1);
    }
    run(proj);
  });
} else {
  run(proj);
} 