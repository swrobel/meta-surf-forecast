import Headroom from 'headroom.js'

import BuoyChart from './components/BuoyChart'
import SpotChart from './components/SpotChart'

require.context('images', true)

function setSafePadding() {
  document.querySelectorAll('.safe-padding')?.forEach(node => {
    if (window.orientation == 90) { // notch is on the left
      node.classList.add('safe-padding-left')
      node.classList.remove('safe-padding-right')
    } else if (window.orientation == -90) { // notch on the right
      node.classList.remove('safe-padding-left')
      node.classList.add('safe-padding-right')
    } else {
      node.classList.remove('safe-padding-left')
      node.classList.remove('safe-padding-right')
    }
  })
}

document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll('.buoy-chart').forEach(container => {
    const props = {
      data: JSON.parse(container.dataset.data || '[]'),
      xLabels: JSON.parse(container.dataset.xlabels || '[]'),
      plotBands: JSON.parse(container.dataset.plotbands || '[]')
    }
    
    BuoyChart.render(container, props)
  })
  
  document.querySelectorAll('.spot-chart').forEach(container => {
    const props = {
      data: JSON.parse(container.dataset.data || '[]'),
      max: JSON.parse(container.dataset.max || '[]'),
      xLabels: JSON.parse(container.dataset.xlabels || '[]'),
      plotBands: JSON.parse(container.dataset.plotbands || '[]')
    }
    
    SpotChart.render(container, props)
  })

  setSafePadding()
  const navbar = document.querySelector(".navbar")
  if (navbar) {
    new Headroom(navbar, {
      "classes": {
        "initial": "animated",
        "pinned": "slideDown",
        "unpinned": "slideUp"
      }
    }).init()

    if (window.location.hash) {
      setTimeout(() => {
        document.getElementById(window.location.hash.slice(1))?.scrollIntoView()
        navbar.classList.add("slideUp")
      }, 1000)
    }
  }
})

window.addEventListener("orientationchange", setSafePadding)
