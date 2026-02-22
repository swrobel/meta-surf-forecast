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

/**
 * Progressive chart renderer using Intersection Observer for lazy loading
 * Only renders charts when they enter the viewport
 */
class ChartRenderer {
  constructor() {
    this.charts = new Map()
    this.pendingCharts = []
    this.renderBatchSize = 2 // Render 2 charts at a time
    this.isRendering = false
    
    // Create intersection observer for lazy loading
    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersection(entries),
      {
        root: null,
        rootMargin: '50px', // Start loading slightly before visible
        threshold: 0
      }
    )
  }

  /**
   * Register a chart container for lazy rendering
   */
  register(container, chartType, propsGetter) {
    // Mark container as pending
    container.classList.add('chart-pending')
    
    // Store chart info
    this.charts.set(container, {
      type: chartType,
      propsGetter,
      rendered: false
    })
    
    // Start observing this container
    this.observer.observe(container)
  }

  /**
   * Handle intersection observer events
   */
  handleIntersection(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const container = entry.target
        const chartInfo = this.charts.get(container)
        
        if (chartInfo && !chartInfo.rendered) {
          // Add to pending queue if not already there
          if (!this.pendingCharts.includes(container)) {
            this.pendingCharts.push(container)
          }
          
          // Start rendering if not already in progress
          if (!this.isRendering) {
            this.processQueue()
          }
        }
      }
    })
  }

  /**
   * Process the rendering queue in batches
   */
  processQueue() {
    if (this.pendingCharts.length === 0) {
      this.isRendering = false
      return
    }

    this.isRendering = true
    
    // Use requestIdleCallback for better scheduling, fallback to setTimeout
    const scheduleRender = window.requestIdleCallback || 
      ((cb) => setTimeout(cb, 0))

    scheduleRender(() => {
      // Process a batch of charts
      const batch = this.pendingCharts.splice(0, this.renderBatchSize)
      
      batch.forEach(container => {
        const chartInfo = this.charts.get(container)
        if (chartInfo && !chartInfo.rendered) {
          try {
            // Get props (lazy parse JSON)
            const props = chartInfo.propsGetter()
            
            // Render the chart
            const chartInstance = chartInfo.type.render(container, props)
            
            // Mark as rendered
            chartInfo.rendered = true
            container.classList.remove('chart-pending')
            container.classList.add('chart-loaded')
            
            // Stop observing once rendered
            this.observer.unobserve(container)
          } catch (error) {
            console.error('Failed to render chart:', error)
            container.classList.add('chart-error')
          }
        }
      })

      // Continue processing queue
      this.processQueue()
    }, { timeout: 1000 })
  }

  /**
   * Render all remaining charts (useful for print or full page load)
   */
  renderAll() {
    this.charts.forEach((chartInfo, container) => {
      if (!chartInfo.rendered && !this.pendingCharts.includes(container)) {
        this.pendingCharts.push(container)
      }
    })
    
    if (!this.isRendering) {
      this.processQueue()
    }
  }
}

// Initialize the chart renderer
const chartRenderer = new ChartRenderer()

document.addEventListener("DOMContentLoaded", function() {
  // Register buoy charts for lazy loading
  document.querySelectorAll('.buoy-chart').forEach(container => {
    chartRenderer.register(container, BuoyChart, () => ({
      data: JSON.parse(container.dataset.data || '[]'),
      xLabels: JSON.parse(container.dataset.xlabels || '[]'),
      plotBands: JSON.parse(container.dataset.plotbands || '[]')
    }))
  })
  
  // Register spot charts for lazy loading
  document.querySelectorAll('.spot-chart').forEach(container => {
    chartRenderer.register(container, SpotChart, () => ({
      data: JSON.parse(container.dataset.data || '[]'),
      max: JSON.parse(container.dataset.max || '[]'),
      xLabels: JSON.parse(container.dataset.xlabels || '[]'),
      plotBands: JSON.parse(container.dataset.plotbands || '[]')
    }))
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
