const { rspack } = require("@rspack/core")
const { merge } = require("webpack-merge")
const ReactRefreshPlugin = require("@rspack/plugin-react-refresh")
const { generateRspackConfig } = require('shakapacker/rspack')

const rspackConfig = generateRspackConfig()

module.exports = merge(rspackConfig, {
  module: {
    plugins: [new rspack.CssExtractRspackPlugin(), new ReactRefreshPlugin(), new rspack.HotModuleReplacementPlugin(), new rspack.SwcJsMinimizerRspackPlugin()],
    rules: [
      {
        test: /\.(png|jpg|gif)$/,
        type: 'asset/resource'
      },
      {
        test: /\.(js|jsx|ts|tsx)$/,
        loader: "builtin:swc-loader",
        options: {
          jsc: {
            parser: {
              syntax: "ecmascript",
              jsx: true
            },
            transform: {
              react: {
                runtime: "automatic"
              }
            }
          }
        }
      }
    ]
  }
})
