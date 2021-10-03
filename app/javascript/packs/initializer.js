$(document).on("turbolinks:load", function () {
  if ($(".selectize")) {
    $(".selectize").selectize({
      sortField: "text",
    })
  }
})
