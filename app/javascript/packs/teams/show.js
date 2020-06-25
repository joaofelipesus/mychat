function send_message(){
  const body = $('#message_body').val()
  const current_group = localStorage.getItem('current-group')
  const message = {
    body: body,
    group_id: current_group
  }
  $.ajax({
    url: '/messages',
    data: { message: message },
    method: 'POST',
    success: response => {
      console.log(response);
    },
    error: response => {
      console.log('Errrooooooo');
      console.log(response)
    }
  })
}

$(document).on('turbolinks:load', () => {

  $('#message_body').keypress(e => {
    if(e.which == 13)
      send_message()
  })

})
