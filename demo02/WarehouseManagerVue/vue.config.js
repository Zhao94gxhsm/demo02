module.exports = {
  devServer: {
      open: true, // 配置自动启动浏览器
      host: "localhost",
      port: 9132,
      proxy: {
          '/': {
              target: 'http://localhost:9131',
              changeOrigin: true
          }
      }
  },
  lintOnSave: false
};