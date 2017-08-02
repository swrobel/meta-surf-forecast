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
      'LightSkyBlue',
      'DodgerBlue',
      'RoyalBlue',
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
      enabled: false,
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
