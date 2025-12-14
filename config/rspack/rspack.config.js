const { generateRspackConfig } = require('shakapacker/rspack')
const { rspack } = require("@rspack/core")

module.exports = generateRspackConfig({
  module: {
    plugins: [new rspack.CssExtractRspackPlugin(), new rspack.HotModuleReplacementPlugin(), new rspack.SwcJsMinimizerRspackPlugin()],
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
          }
        }
      }
    ]
  }
})
