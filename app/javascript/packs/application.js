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

import 'bootstrap/dist/js/bootstrap'
require("stylesheets/application.scss")
require("trix")
require("@rails/actiontext")

import "chartkick/chart.js"
import "cocoon-js-vanilla"

require("jquery")
require("jquery-ui-dist/jquery-ui")
require("selectize")

import "./lesson-sortable"
import "./trix-overrides"
import "./youtube"
import "./videos"
import "./selectize"

// theme related
// require( 'datatables.net-bs4' )();
// require( 'datatables.net-autofill-bs4' )();
// require( 'datatables.net-buttons-bs4' )();
// require( 'datatables.net-colreorder-bs4' )();
// require( 'datatables.net-responsive-bs4' )();
// require( 'datatables.net-rowreorder-bs4' )();
// require( 'datatables.net-searchPanes' )();
// require( 'datatables.net-select-bs4' )();
// import "datatables.net"
import "datatables"
// require("datatables.net")
// import "datatables.net-autofill"
// import "datatables.net-bs4"
// require("datatables.net-buttons")()
// require("datatables.net-colreorder")()
// require("datatables.net-keytable")()
// import "moment"

import "autosize"
import "bootstrap-notify"
import "bootstrap-submenu"

import "./js/common"
import "./js/scripts"
import "./js/base/loader"



// jquery.validate
// autoComplete
// baguetteBox
// Chart
// input-spinner
// jquery.barrating
// jquery.contextMenu
// moment-with-locales
// movecontent
// OverlayScrollbars
// quill.active
// singleimageupload