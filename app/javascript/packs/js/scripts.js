import { Globals, Variables } from "./base/globals"
import { Nav } from "./base/nav"
import { Common } from "./common"
import { Settings } from "./base/settings"

// <!-- Icons Start -->
import "../../icon/acorn-icons-interface"
import "../../icon/acorn-icons-learning"
import { AcornIcons } from "../../icon/acorn-icons"
// <!-- Icons End -->

/**
 *
 * Scripts
 *
 * Initialization of the template base and page scripts.
 *
 *
 */
//  var Globals = Globals || {};

class Scripts {
  constructor() {
    this._initSettings()
    this._initVariables()
    this._addListeners()
    this._init()
  }

  // Showing the template after waiting for a bit so that the css variables are all set
  // Initialization of the common scripts and page specific ones
  _init() {
    setTimeout(() => {
      document.documentElement.setAttribute("data-show", "true")
      document.body.classList.remove("spinner")
      this._initBase()
      this._initCommon()
      this._initPages()
    }, 100)
  }

  // Base scripts initialization
  _initBase() {
    // Navigation
    if (typeof Nav !== "undefined") {
      const nav = new Nav(document.getElementById("nav"))
    }

    // Search implementation
    if (typeof Search !== "undefined") {
      const search = new Search()
    }

    // AcornIcons initialization
    if (typeof AcornIcons !== "undefined") {
      new AcornIcons().replace()
    }
  }

  // Common plugins and overrides initialization
  _initCommon() {
    // common.js initialization
    if (typeof Common !== "undefined") {
      let common = new Common()
    }
  }

  _initPages() {
    // horizontal.js initialization
    if (typeof HorizontalPage !== "undefined") {
      const horizontalPage = new HorizontalPage()
    }

    // vertical.js initialization
    if (typeof VerticalPage !== "undefined") {
      const verticalPage = new VerticalPage()
    }

    // course.explore.js initialization
    if (typeof CourseExplore !== "undefined") {
      const courseExplore = new CourseExplore()
    }
  }

  // Settings initialization
  _initSettings() {
    if (typeof Settings !== "undefined") {
      const settings = new Settings(
        {
          attributes: {
            placement: "vertical",
            color: "dark-purple",
            behaviour: "unpinned",
            layout: "boxed"
          },
          showSettings: true,
          storagePrefix: "videoskwela-project-" }
        )
    }
  }

  // Variables initialization of Globals.js file which contains valus from css
  _initVariables() {
    if (typeof Variables !== "undefined") {
      const variables = new Variables()
    }
  }

  // Listeners of menu and layout changes which fires a resize event
  _addListeners() {
    document.documentElement.addEventListener(Globals.menuPlacementChange, event => {
      setTimeout(() => {
        window.dispatchEvent(new Event("resize"))
      }, 25)
    })

    document.documentElement.addEventListener(Globals.layoutChange, event => {
      setTimeout(() => {
        window.dispatchEvent(new Event("resize"))
      }, 25)
    })

    document.documentElement.addEventListener(Globals.menuBehaviourChange, event => {
      setTimeout(() => {
        window.dispatchEvent(new Event("resize"))
      }, 25)
    })
  }
}

// Shows the template after initialization of the settings, nav, variables and common plugins.
;(function () {
  window.addEventListener("turbolinks:load", () => {
    // Initializing of the Scripts
    if (typeof Scripts !== "undefined") {
      const scripts = new Scripts()
    }
  })
})()

// Disabling dropzone auto discover before DOMContentLoaded
;(function () {
  if (typeof Dropzone !== "undefined") {
    Dropzone.autoDiscover = false
  }
})()
