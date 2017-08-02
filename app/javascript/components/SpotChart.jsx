import React from 'react'
import ReactDOM from 'react-dom'
import Highcarts from 'highcharts'
import ReactHighcharts from 'react-highcharts'

const SpotChart = props => {
  const config = {
    chart: {
      marginRight: 2,
      style: {
        fontFamily: 'inherit',
      },
      type: 'column',
    },
    colors: [
      '#D1DCE4',
      '#9EAAB3',
      '#6A7177',
    ],
    credits: {
      enabled: false,
    },
    legend: {
      borderWidth: 0,
      margin: 0,
    },
    plotOptions: {
      areaspline: {},
      column: {
        borderWidth: 0,
        groupPadding: 0.07,
        dataLabels: {
          enabled: false,
        },
      },
      series: {
        marker: {},
        stacking: 'normal',
      },
    },
    series: props.data,
    title: {
      text: null,
    },
    tooltip: {
      formatter: function() {
        let rating
        let min = 0
        let avg = 0
        let tooltip = `<strong>${this.x}</strong>`
        for (const point of this.points.reverse()) {
          tooltip += `<br>${point.series.name}: ${(min + avg + point.y).toPrecision(2)} ft`
          if (point.series.name === 'Min') {
            rating = point.point.rating
            min = point.y
          }
          if (point.series.name === 'Avg') avg = point.y
        }
        tooltip += `<br>Rating: ${rating}`
        return tooltip
      },
      shared: true,
    },
    xAxis: {
      categories: props.xLabels,
      title: {
        text: null,
      },
    },
    yAxis: {
      max: props.max,
      stackLabels: {
        enabled: true,
        style: {
          fontSize: '0.65em',
          fontWeight: 'normal',
        },
      },
      tickInterval: 1,
      title: {
        text: null
      },
    },
  }

  return(<ReactHighcharts config = {config}></ReactHighcharts>)
}

export default SpotChart
