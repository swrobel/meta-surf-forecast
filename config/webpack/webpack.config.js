const { generateWebpackConfig, env } = require('shakapacker')
const customConfig = {
  resolve: {
    extensions: ['.css']
  }
}

if (env.isDevelopment) {
  const chokidar = require('chokidar')
  customConfig.devServer = {
    onBeforeSetupMiddleware: (devServer) => {
      chokidar
        .watch(['config/locales/*.yml', 'app/views/**/*.slim'])
        .on("change", () =>
          devServer.sendMessage(
            devServer.webSocketServer.clients,
            "content-changed"
          )
        )
    }
  }
}

module.exports = generateWebpackConfig(customConfig)
