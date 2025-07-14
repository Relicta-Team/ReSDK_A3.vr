/*

https://github.com/ultralight-ux/Ultralight
https://github.com/arma3/RVExtensionImGui/blob/main/dllmain.cpp

*/

const path = require("path");
const fs = require("fs");
const HtmlWebpackPlugin = require("html-webpack-plugin");

function getProjectList() {
  const projectsDir = path.resolve(__dirname);
  return fs.readdirSync(projectsDir).filter((name) => {
    const projPath = path.join(projectsDir, name);
    return fs.statSync(projPath).isDirectory() &&
      fs.existsSync(path.join(projPath, "tsconfig.json"));
  });
}

const makeConfig = (projName, mode = "development") => ({
  name: projName,
  mode,
  target: "web", // тк отлаживаем в node.js, web for browser
  entry: `./${projName}/index.ts`,
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, `dist/${projName}`),
    libraryTarget: "umd2", //commonjs2 for debug, web for webbrowser
    clean: true,
    devtoolModuleFilenameTemplate: '[absolute-resource-path]',
  },
  resolve: {
    extensions: [".ts", ".js"]
  },
  devtool: "source-map",
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: "ts-loader",
        options: {
          configFile: `projects/${projName}/tsconfig.json`
        },
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    alias: {
      Core: path.resolve(__dirname, "HtmlUICore/Core.ts")
    }
  },
  externals: {
    "./A3API": "A3API"
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, `${projName}/index.html`),
      filename: "index.html"
    })
  ]
});

module.exports = (env = {}) => {
  const project = env.proj;
  const mode = env.mode || "development";
  const lst = getProjectList();
  console.log("Project list:", lst);
  if (project) {
    return makeConfig(project, mode);
  }
  return lst.map(proj => makeConfig(proj, mode));
};
