/*
  Создание проекта
  npm run make-project --project=test
*/
const fs = require("fs");
const path = require("path");
const readline = require('readline');
const { colorize, colors } = require("./util");
const workDir = path.resolve(path.join(__dirname, '..', '..'));

let projectName = process.env.npm_config_project;

function createProject(projectName) {
  const projectPath = path.join(workDir, projectName);
  const targetTsconfig = path.join(projectPath, "tsconfig.json");
  const indexPath = path.join(projectPath, "index.ts");

  // 1. Проверка существования
  if (fs.existsSync(projectPath)) {
    console.error(colorize(`❌ Project ${projectName} already exists`, colors.red));
    process.exit(1);
  }

  // 2. Создание папки
  fs.mkdirSync(projectPath, { recursive: true });

  // 3. tsconfig.json
  const tsconfigContent = {
    extends: "../WebUI/tsconfig.json",
    compilerOptions: {
      outDir: `../WebUI/dist/${projectName}`
    },
    include: ["**/*.ts","../WebUI/**/*.ts"]
  };

  fs.writeFileSync(targetTsconfig, JSON.stringify(tsconfigContent, null, 2));

  // 4. index.ts
  const indexTemplate = `export function run() {
    const message = 'hello from ${projectName}';
    console.log(message);
  }

  run();
  `;

  fs.writeFileSync(indexPath, indexTemplate);

  // 5. index.html
  const htmlTemplate = `<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8" />
  <title>${projectName} Debug</title>
</head>
<body>
  <h1>${projectName} loaded</h1>
  <!-- bundle.js will be injected by html-webpack-plugin -->
</body>
</html>
`;
  fs.writeFileSync(path.join(projectPath, "index.html"), htmlTemplate);

  console.log(colorize(`✅ Project ${projectName} created in projects/${projectName}`, colors.green));
  console.log(colorize(`👉 Add to package.json:`, colors.cyan));
  console.log(colorize(`   \"build:${projectName}\": \"webpack --env proj=${projectName}\"`, colors.yellow));
}

if (!projectName) {
  const rl = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
  });
  rl.question("Enter project name: ", (name) => {
    rl.close();
    if (!name) {
      console.error(colorize("❌ Please specify a project name: node create-project.js proj2", colors.red));
      process.exit(1);
    }
    if (!/^[a-zA-Z0-9_-]+$/.test(name)) {
      console.error(colorize("❌ Project name must contain only letters, numbers, - or _", colors.red));
      process.exit(1);
    }
    createProject(name);
  });
} else {
  if (!/^[a-zA-Z0-9_-]+$/.test(projectName)) {
    console.error(colorize("❌ Project name must contain only letters, numbers, - or _", colors.red));
    process.exit(1);
  }
  createProject(projectName);
}