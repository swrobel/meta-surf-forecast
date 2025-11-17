const { rspack } = require("@rspack/core")
const { merge } = require("webpack-merge")
const baseConfig = require("shakapacker")
const ReactRefreshPlugin = require("@rspack/plugin-react-refresh")

module.exports = merge(baseConfig, {
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
