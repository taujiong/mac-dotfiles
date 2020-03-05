// 此文件用于让 webstorm 正确识别 webpack 的路径别名
const resolve = dir => require("path").join(__dirname, dir);

module.exports = {
  resolve: {
    alias: {
      "src": resolve(__dirname, "/src"),
      "app": resolve(__dirname, "/"),
      "components": resolve(__dirname, "/src/components"),
      "layouts": resolve(__dirname, "/src/layouts"),
      "pages": resolve(__dirname, "/src/pages"),
      "boot": resolve(__dirname, "/src/boot"),
      "assets": resolve(__dirname, "/src/assets")
    }
  }
};
