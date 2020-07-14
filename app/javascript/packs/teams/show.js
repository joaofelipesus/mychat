import Message  from '../messages/lib'

$(document).ready(() => {
  $('.message').remove()
  Message.load()
  $('#message_body').keypress(e => {
    if(e.which == 13)
      Message.send()
  })
})
