// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "stylesheets/application.scss"

// <!-- Application Specific Start -->
// require("trix")
// require("@rails/actiontext")
// import "chartkick/chart.js"
// import "cocoon-js-vanilla"
// require("jquery")
// require("jquery-ui-dist/jquery-ui")
// require("selectize")
// import "./lesson-sortable"
// import "./trix-overrides"
// import "./youtube"
// import "./videos"
// import "./selectize"
// <!-- Application Specific End -->

// <!-- Vendor Scripts Start -->
import "moment"
// import "bootstrap"
// import "./js/vendor/bootstrap.bundle.min";

// import "./js/vendor/jquery-3.5.1.min"
// import "overlayscrollbars"
// import "./js/vendor/autoComplete.min"
// import "./js/vendor/clamp.min"
// import "./js/vendor/glide.min"
// import "./js/vendor/Chart.bundle.min"
// import "./js/vendor/jquery.barrating.min"
// <!-- Vendor Scripts End -->

// <!-- Template Base Scripts Start -->
// import "./js/base/helpers"
// import "./js/base/globals"
// import "./js/base/nav"
// import "./js/base/search"
// import "./js/base/settings"
// <!-- Template Base Scripts End -->

// <!-- Page Specific Scripts Start -->
// import "./js/cs/glide.custom"
// import "./js/cs/charts.extend"
// import "./js/pages/dashboard.elearning"
// require("./js/common") // in script

import "./js/scripts"
// <!-- Page Specific Scripts End -->
