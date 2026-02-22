import Highcharts from 'highcharts'

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
        accessibility: {
          enabled: false,
        },
        boost: {
          useGPUTranslations: true,
          usePreAllocated: true
        },
        chart: {
          animation: false, // Disable animation for faster rendering
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
        plotOptions: {
          series: {
            animation: false, // Disable series animation
            turboThreshold: 1000 // Increase threshold for boost module
          }
        },
        series: props.data,
        title: {
          text: null,
        },
        tooltip: {
          animation: false, // Disable tooltip animation for better performance
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
          shared: true,
        },
        xAxis: {
          categories: props.xLabels,
          labels: {
            style: {
              color: null,
            }
          },
          plotBands: props.plotBands,
          title: {
            text: null,
          },
        },
        yAxis: {
          labels: {
            style: {
              color: null,
            }
          },
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
