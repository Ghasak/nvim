# ASCIIFLOW

ASCIIFlow is built with Bazel. Bazel is most easily installed to the correct
version through Bazelisk. See .bazelversion for the correct version if you
aren't using Bazelisk.

## Start the server

1. After Install and clone the repository, you can use

```sh
bazel run client:devserver
```

2. It will operate on port `8080` by default, but I have managed to change it
   using the following:

- Navigate to the client directory of the project located in
  `~/Desktop/devCode/javaScriptHub/asciiflow`. Use `vim webpack.config.js` and

- Insert the line `port: 9090, // Set the development server to listen on port 9090 for example` within it. Refer to the attached `webpack.config.js Template`
  to ensure correctness at the end. Check the file after making this addition.

## Installation

1. Copy the repository locally
2. Ensure that you have `bazelisk` and `ibazel` using

```sh
npm install -g @bazel/bazelisk
yarn global add @bazel/bazelisk
```

For development, ibazel is also a very useful tool to help with automatic rebuilding and reloading.

```sh
npm install -g @bazel/ibazel
yarn global add @bazel/ibazel
```

Running ASCIIFlow locally

After installation of Bazel/Bazelisk, you can run ASCIIFlow locally with:

```sh
ibazel run client:devserver
```

Or without ibazel (won't do live reloading):

```sh
bazel run client:devserver
```

## References

Read more [here](https://github.com/lewish/asciiflow)

## webpack.config.js Template

```ts
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const { env } = require("process");

module.exports = (env, argv) => ({
  plugins:
    argv.mode != "production"
      ? [
          new HtmlWebpackPlugin({
            template: path.resolve(__dirname, "index.html"),
            inject: false,
          }),
        ]
      : [],
  devServer: {
    static: {
      directory: path.resolve(__dirname),
    },

    port: 9090, // Set the development server to listen on port 9090
  },
  entry: {
    bundle: path.resolve(__dirname, "./app.js"),
  },
  devtool: false,
  output: {
    path: path.resolve(__dirname),
    filename: "[name].js",
    publicPath: "/",
  },
  resolve: {
    alias: {
      "#asciiflow": path.resolve("."),
    },
  },
  module: {
    rules: [
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(?:js|mjs|cjs)$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: [["@babel/preset-env", { targets: "defaults" }]],
            plugins: [
              [
                "@babel/plugin-proposal-decorators",
                {
                  version: "2023-05",
                },
              ],
            ],
          },
        },
      },
    ],
  },
});
```
