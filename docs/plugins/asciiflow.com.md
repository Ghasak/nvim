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
   using the following

- Go to the client directory of the `~/Desktop/devCode/javaScriptHub/asciiflow` project.
- Use `vim webpack.config.js` and add the line `port: 9090, // Set the development server to listen on port 9090 for example`.

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




