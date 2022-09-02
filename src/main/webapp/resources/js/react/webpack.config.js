// webpack config
const path = require('node:path');

const entryName = "member-enroll";
const entryFileFormat = ".jsx"
const projectAbsPath = 'C:/Workspaces/spring_workspace/final-project-eatwith/src/main/webapp/resources/js'

module.exports = {
  mode: 'production', // 1
  entry: `${projectAbsPath}/react/src/${entryName+entryFileFormat}`, // 2
  output: { // 3
    path: `${projectAbsPath}/bundle`,
    filename: `${entryName+".js"}` // 4
  },
  module:{
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react']
          }
        }
      }
    ]
  }
};