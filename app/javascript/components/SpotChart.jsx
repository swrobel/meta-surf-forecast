import React from 'react'
import ReactDOM from 'react-dom'
import ReactHighcharts from 'react-highcharts'

const SpotChart = props => {
  const config = {
    chart: {
      marginRight: 2,
      spacingLeft: 0,
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
        let avg = 0
        let min = 0
        let rating
        let timestamp
        let tooltip = ''
        for (const point of this.points.reverse()) {
          tooltip += `<br>${point.series.name}: ${(min + avg + point.y).toPrecision(2)} ft`
          if (point.series.name === 'Min') {
            tooltip = `<strong>${new Date(point.point.timestamp).toLocaleString('en-US', {day: 'numeric', month: 'short', hour: 'numeric', weekday: 'short'})}</strong>${tooltip}`
            rating = point.point.rating
            min = point.y
          }
          if (point.series.name === 'Avg') avg = point.y
        }
        tooltip += `<br>${rating}`
        return tooltip
      },
      shared: true,
    },
    xAxis: {
      categories: props.xLabels,
      plotBands: props.plotBands,
      title: {
        text: null,
      },
    },
    yAxis: {
      max: props.max,
      offset: -8,
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
