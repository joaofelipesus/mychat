$(document).on("turbolinks:load", () => {

  $('.modal').modal();

  $.ajax({
    url: '/team_users',
    dataType: 'json',
    success: response => {
      const invite = response["team_user"]
      $("#team-invite-slug").text(invite["team"]["slug"])
      $('#new-invite-modal').modal('open')
      $('#accept-invite').attr('data-value', invite.id)
      $('#decline-invite').attr('data-value', invite.id)
    }
  })

  $('#accept-invite').on('click', event => {
    const team_user_id = $(event.target).attr('data-value')
    $.ajax({
      url: `/team_users/${team_user_id}`,
      method: 'PATCH',
      data: { team_user: { inviting_status: "confirmed" } },
      dataType: 'json',
      success: response => {
        M.toast({ html: 'Invite accepted', classes: 'green' })
        $('#new-invite-modal').modal('close')
      },
      error: response => {
        M.toast({ html: response["errors"][0], classes: 'red' })
      }
    })
  })

  $('#decline-invite').on('click', event => {
    const team_user_id = $(event.target).attr('data-value')
    $.ajax({
      url: `/team_users/${team_user_id}`,
      method: 'DELETE',
      dataType: 'json',
      success: response => {
        M.toast({ html: 'Inite declined', classes: 'green'})
        $('#new-invite-modal').modal('close')
      },
      error: response => {
        const error_message = response["errors"][0]
        M.toast({ html: error_message, classes: 'red' })
      }
    })
  })

})
