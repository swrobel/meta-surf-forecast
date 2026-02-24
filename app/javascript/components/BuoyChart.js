import Highcharts from 'highcharts'
import chartConfig from './chartConfig'

const BuoyChart = {
  /**
   * Renders a buoy chart in the specified container
   * @param {HTMLElement} container - The DOM element to render the chart in
   * @param {Object} props - The chart properties (data, xLabels, plotBands)
   * @returns {Object} - The Highcharts instance
   */
  render(container, props) {
    try {
      const options = {
        ...chartConfig,
        chart: {
          ...chartConfig.chart,
          type: 'spline',
        },
        series: props.data,
        tooltip: {
          ...chartConfig.tooltip,
          formatter: function() {
            let tooltip = ''
            let tooltip_time = ''
            for (const point of this.points) {
              if (point.tooltip_time) tooltip_time = point.tooltip_time
              tooltip += `<br><span style="color:${point.series.color}">●</span> ${point.series.name}: ${point.y.toPrecision(2)}ft from ${point.point.direction}° (${point.point.swell.toPrecision(2)}ft @ ${point.point.period}s)`
            }
            tooltip = `<strong>${tooltip_time}</strong>${tooltip}`
            return tooltip
          },
        },
        xAxis: {
          ...chartConfig.xAxis,
          categories: props.xLabels,
          labels: {
            style: {
              color: null,
            }
          },
          plotBands: props.plotBands,
          tickLength: 12,
          tickmarkPlacement: 'on',
        },
        yAxis: {
          ...chartConfig.yAxis,
          labels: {
            style: {
              color: null,
            }
          },
          min: 0,
          stackLabels: {
            enabled: true,
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
      console.error('Error rendering buoy chart:', error)
      
      // Display error message in container
      container.innerHTML = '<div class="chart-error">Failed to load chart</div>'
      return null
    }
  }
}

export default BuoyChart
