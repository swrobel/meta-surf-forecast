import Highcharts from 'highcharts'
import chartConfig from './chartConfig'

const SpotChart = {
  /**
   * Renders a spot chart in the specified container
   * @param {HTMLElement} container - The DOM element to render the chart in
   * @param {Object} props - The chart properties (data, xLabels, plotBands, max)
   * @returns {Object} - The Highcharts instance
   */
  render(container, props) {
    try {
      const options = {
        ...chartConfig,
        chart: {
          ...chartConfig.chart,
          styledMode: true,
          type: 'column',
        },
        plotOptions: {
          ...chartConfig.plotOptions,
          areaspline: {
            animation: false
          },
          column: {
            animation: false,
            borderRadius: 0,
            borderWidth: 0,
            groupPadding: 0.07,
            dataLabels: {
              enabled: false,
            },
          },
          series: {
            ...chartConfig.plotOptions.series,
            marker: {},
            stacking: 'normal',
          },
        },
        series: props.data,
        tooltip: {
          ...chartConfig.tooltip,
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
            tooltip += `<br><i>${rating}</i>`
            tooltip += `<br>Max: ${(min + avg + max).toPrecision(2)} ft`
            tooltip += `<br>Avg: ${(min + avg).toPrecision(2)} ft`
            tooltip += `<br>Min: ${min.toPrecision(2)} ft`
            return tooltip
          },
        },
        xAxis: {
          ...chartConfig.xAxis,
          categories: props.xLabels,
          plotBands: props.plotBands,
          tickLength: 16,
        },
        yAxis: {
          ...chartConfig.yAxis,
          max: props.max,
          stackLabels: {
            enabled: true,
            formatter: function() {
              return Highcharts.numberFormat(this.total, 1);
            },
            style: {
              fontSize: '0.65em',
              fontWeight: 'normal',
            },
          },
        },
      }

      // Create and return the chart
      return Highcharts.chart(container, options)
    } catch (error) {
      console.error('Error rendering spot chart:', error)
      
      // Display error message in container
      container.innerHTML = '<div class="chart-error">Failed to load chart</div>'
      return null
    }
  }
}

export default SpotChart
