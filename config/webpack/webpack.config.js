const { generateWebpackConfig, env } = require('shakapacker')
const customConfig = {
  resolve: {
    extensions: ['.css']
  }
}

if (env.isDevelopment) {
  customConfig.devServer = {
    watchFiles: ['config/locales/*.yml', 'app/views/**/*.slim']
  }
}

module.exports = generateWebpackConfig(customConfig)
