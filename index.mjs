import React from "react"
import { createRoot } from "react-dom"
import { appText } from "./output/Main/index.js"

const container = document.getElementById("purescript-app")
const root = createRoot(container)
root.render(<div>{ appText }</div>)
