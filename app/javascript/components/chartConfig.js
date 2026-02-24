const chartConfig = {
  accessibility: {
    enabled: false,
  },
  boost: {
    useGPUTranslations: true,
    usePreAllocated: true
  },
  chart: {
    animation: false,
    marginRight: 2,
    spacingLeft: 0,
    style: {
      fontFamily: 'inherit',
    },
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
      animation: false,
      turboThreshold: 1000
    }
  },
  title: {
    text: null,
  },
  tooltip: {
    animation: false,
    shared: true,
  },
  xAxis: {
    tickWidth: 1,
    tickPosition: 'outside',
    title: {
      text: null,
    },
  },
  yAxis: {
    offset: -8,
    tickInterval: 1,
    title: {
      text: null
    },
  },
}

export default chartConfig
