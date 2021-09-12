// prevents attachments:
document.addEventListener("trix-file-accept", function (event) {
  event.preventDefault()
})

document.addEventListener("turbolinks:load", () => {
  const uploadButtons = document.querySelectorAll(".trix-button--icon-attach")

  uploadButtons.forEach(uploadButton => {
    uploadButton.disabled = true
    uploadButton.parentElement.style.display = "none"
  })
})
