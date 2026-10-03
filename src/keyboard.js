document.addEventListener("keydown", function (e) {
  const ids = Array.from(document.querySelectorAll(".popup"))
    .map((element) => element.id);

  const current = location.hash.replace("#", "");
  const index = ids.indexOf(current);

  if (index !== -1) {
    if (e.key === "ArrowRight") {
      location.hash = `#${ids[(index + 1) % ids.length]}`;
    } else if (e.key === "ArrowLeft") {
      location.hash = `#${ids[(index - 1 + ids.length) % ids.length]}`;
    } else if (e.key === "Escape") {
      history.replaceState(null, "", window.location.pathname + window.location.search);
    }
  }
});
