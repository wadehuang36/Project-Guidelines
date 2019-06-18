import { Platform } from "react-native"

export const StringRes = {
  app: {
    welcome: "Welcome to React Native!",
    instruction: "To get started, edit app/src/scenes/app.tsx",
    instructions: Platform.select({
      ios: "Press Cmd+R to reload,\nCmd+D or shake for dev menu",
      android: "Double tap R on your keyboard to reload,\nShake or press menu button for dev menu"
    })
  }
}
