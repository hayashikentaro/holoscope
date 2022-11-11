import React from "react"
import ReactDom from "react-dom"
import { appText } from "./output/Main/index.js"

const App = () => {
  return (
    <>
      <div>{appText}</div>
    </>
  )
}
ReactDom.render(<App />, document.getElementById("purescript-app"))