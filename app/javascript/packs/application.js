// Support component names relative to this directory:
const componentRequireContext = require.context("components", true)
const ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)

const Headroom = require("headroom.js")

document.addEventListener("DOMContentLoaded", function() {
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
      setTimeout(() => navbar.classList.add("slideUp"), 100)
    }
  }
})
