import React, { Component } from "react"
import { StyleSheet, Text, View } from "react-native"
import { StringRes } from "../../res/string-res"

interface Props {}

export default class App extends Component<Props> {
  render(): React.ReactElement {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>{StringRes.app.welcome}</Text>
        <Text style={styles.instructions}>{StringRes.app.instruction}</Text>
        <Text style={styles.instructions}>{StringRes.app.instructions}</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#F5FCFF"
  },
  welcome: {
    fontSize: 20,
    textAlign: "center",
    margin: 10
  },
  instructions: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5
  }
})
