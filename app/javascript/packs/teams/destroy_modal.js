$(document).on("turbolinks:load", () => {

  $('.modal').modal();

  $('.destroy-team').on('click', event => {
    const team_id = $(event.target).attr('data-value')
    $('#btn-destroy-team').attr('data-value', team_id)
  })


  $('#btn-destroy-team').on('click', event => {
    const team_id = $(event.target).attr('data-value')
    $.ajax({
      url: `/teams/${team_id}`,
      method: 'DELETE',
      success: response => {
        M.toast({html: 'Team destroyed', classes: 'green', displayLength: 8000 })
        window.location.replace('/');
      },
      error: (response) => {
        M.toast({html: response.statusText, classes: 'red'})
      }
    })
  })


});
