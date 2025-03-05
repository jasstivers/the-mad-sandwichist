import Chartjs from "@stimulus-components/chartjs"

export default class extends Chartjs {
  connect() {
    super.connect()
    console.log("The chart controller is connected!")

    // The chart.js instance
    // this.chart

    // Options from the data attribute.
    // this.options

    // Default options for every charts.
    // this.defaultOptions
  }
}
