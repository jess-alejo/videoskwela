// prevents attachments:
// document.addEventListener("trix-file-accept", function (event) {
//   event.preventDefault()
// })

// document.addEventListener("turbolinks:load", () => {
//   const uploadButtons = document.querySelectorAll(".trix-button--icon-attach")

//   uploadButtons.forEach(uploadButton => {
//     uploadButton.disabled = true
//     uploadButton.parentElement.style.display = "none"
//   })
// })

window.addEventListener("trix-file-accept", function (event) {
  const maxFileSize = 3000 * 3000 // around 9MB
  if (event.file.size > maxFileSize) {
    event.preventDefault()
    alert("Only support attachment files upto size 9MB!")
  }
})