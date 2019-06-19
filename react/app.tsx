import React from "react"
import logo from "../res/images/logo.svg"
import "./app.css"
import { StringRes } from "../res/string-res"

const App: React.FC = (): React.ReactElement => {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>{StringRes.app.title}</p>
        <a className="App-link" href={StringRes.app.linkUrl} target="_blank" rel="noopener noreferrer">
          {StringRes.app.linkText}
        </a>
      </header>
    </div>
  )
}

export default App
