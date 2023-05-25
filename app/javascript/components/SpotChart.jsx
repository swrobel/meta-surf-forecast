import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'
import React from 'react'
import Bugsnag from '@bugsnag/js'

const SpotChart = props => {
  const options = {
    chart: {
      marginRight: 2,
      spacingLeft: 0,
      style: {
        fontFamily: 'inherit',
      },
      styledMode: true,
      type: 'column',
    },
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
        borderRadius: 0,
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
        let max = 0
        let rating
        let tooltip = ''
        for (const point of this.points.reverse()) {
          if (point.series.name === 'Min') {
            tooltip = `<strong>${point.point.tooltip_time}</strong>${tooltip}`
            rating = point.point.rating
            min = point.y
          } else if (point.series.name === 'Avg') avg = point.y
          else max = point.y
        }
        tooltip += `<br>Max: ${(min + avg + max).toPrecision(2)} ft`
        tooltip += `<br>Avg: ${(min + avg).toPrecision(2)} ft`
        tooltip += `<br>Min: ${min.toPrecision(2)} ft`
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
        formatter: function() {
          return  Highcharts.numberFormat(this.total, 1);
        },
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
  const ErrorBoundary = Bugsnag.getPlugin('react')?.createErrorBoundary(React) || React.Fragment

  return(
    <ErrorBoundary>
      <HighchartsReact options={options} highcharts={Highcharts}></HighchartsReact>
    </ErrorBoundary>
  )
}

export default SpotChart
