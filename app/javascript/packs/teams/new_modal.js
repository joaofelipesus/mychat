$(document).on("turbolinks:load", () => {
  var elems = $('#new-team-modal');
  var instances = M.Modal.init(elems);

  $('#new-team-form').on('ajax:success', response => {
    [data, status, xhr] = response.detail
    M.toast({ html: 'Team created !', classes: 'green' })
    window.location.replace(`/${data["team"].slug}`);
  })

  $('#new-team-form').on('ajax:error', response => {
    let errors = response.detail[0]
    let error_message = errors["errors"][0]
    M.toast({ html: error_message, classes: 'red' })
  })

});
