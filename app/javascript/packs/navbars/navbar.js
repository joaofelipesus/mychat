document.addEventListener("turbolinks:load", () => {
  var elems = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(elems);
});

$(document).on('turbolinks:load', () => {
  $(".dropdown-trigger").dropdown();
})
