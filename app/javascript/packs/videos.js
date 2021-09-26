document.addEventListener("turbolinks:load", () => {
  let videos = document.querySelectorAll("video")
  videos.forEach(video => {
    video.addEventListener("contextmenu", e => e.preventDefault())
  })
})
