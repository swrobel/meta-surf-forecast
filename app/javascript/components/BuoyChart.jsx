import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'
import React from 'react'
import Bugsnag from '@bugsnag/js'

const BuoyChart = props => {
  const options = {
    accessibility: {
      enabled: false,
    },
    chart: {
      marginRight: 2,
      spacingLeft: 0,
      style: {
        fontFamily: 'inherit',
      },
      type: 'spline',
    },
    credits: {
      enabled: false,
    },
    legend: {
      borderWidth: 0,
      margin: 0,
    },
    series: props.data,
    title: {
      text: null,
    },
    tooltip: {
      formatter: function() {
        let tooltip = ''
        for (const point of this.points) {
          tooltip += `<br><span style="color:${point.series.color}">●</span> ${point.series.name}: ${point.y.toPrecision(2)}ft from ${point.point.direction}° (${point.point.swell.toPrecision(2)}ft @ ${point.point.period}s)`
        }
        tooltip = `<strong>${this.points[0].point.tooltip_time}</strong>${tooltip}`
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
      min: 0,
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
  const ErrorBoundary = Bugsnag.client ? Bugsnag.getPlugin('react')?.createErrorBoundary(React) : React.Fragment

  return(
    <ErrorBoundary>
      <HighchartsReact options={options} highcharts={Highcharts}></HighchartsReact>
    </ErrorBoundary>
  )
}

export default BuoyChart
