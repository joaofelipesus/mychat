$(document).on("turbolinks:load", () => {
  $('.modal').modal();

  $('#new-group-form').on('ajax:success', response => {
    [data, status, xhr] = response.detail
    M.toast({ html: 'Group created !', classes: 'green' })
    var instance = M.Modal.getInstance($('#new-group-modal'));
    instance.close()
  })

  $('#new-group-form').on('ajax:error', response => {
    let errors = response.detail[0]
    M.toast({ html: errors["errors"][0], classes: 'red' })
  })

})
