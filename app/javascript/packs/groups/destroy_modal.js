$(document).on('turbolinks:load', () => {

  $('.destroy-group').on('click', event => {
    let group_id = $(event.target).attr('data-value')
    const group_slug = $(event.target).parent().find('.group-slug').text()
    $('#btn-destroy-group').attr('data-value', group_id)
    $('#destroy-group-slug').text(group_slug)
  })

  $('#btn-destroy-group').on('click', event => {
    const group_id = $(event.target).attr("data-value")
    $.ajax({
      url: `/groups/${group_id}`,
      dataType: 'json',
      method: 'DELETE',
      success: response => {
        $(`#group-${group_id}`).remove()
        M.toast({ html: 'Group destroyed', classes: 'green' })
        var instance = M.Modal.getInstance($('#destroy-group-modal'));
        instance.close()
      },
      error: response => {
        console.log('error')
        console.log(response)
      }
    })
  })

})
