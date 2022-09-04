// webpack config
const path = require('node:path');

const entryPoint = "memberEnroll/member-enroll.jsx"
const entryName = "member-enroll";
const projectAbsPath = 'C:/Workspaces/spring_workspace/final-project-eatwith/src/main/webapp/resources/js'

module.exports = {
  mode: 'production', // 1
  entry: path.resolve(__dirname,`react/src/${entryPoint}`), // 2
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