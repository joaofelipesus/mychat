const Message = {
  send() {
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
        $('#message_body').val('')
        const message_delivered = response.message
        Message.add(message_delivered)
      },
      error: response => {
        M.toast({ html: response["errors"][0], classes: 'red' })
      }
    })
  },

  add(message){
    const current_user = $('#current-user').text()
    let message_element = null
    if (current_user == message.user_id)
      message_element = `<div class='message right-align'>${message.body}</div>`
    else
      message_element = `<div class="message">${message.body}</div>`
    $('#chat').append(message_element)
  },

  load(){
    const current_group = localStorage.getItem('current-group')
    $.ajax({
      url: `/messages?group=${current_group}`,
      method: 'GET',
      dataType: 'json',
      success: response => {
        const messages = response["messages"]
        messages.forEach(message => Message.add(message))
      },
      error: response => {
        M.toast({ html: response["errors"][0], classes: 'red' })
      }
    })
  }
};

export default Message;












//
// function send_message(){
//   const body = $('#message_body').val()
//   const current_group = localStorage.getItem('current-group')
//   const message = {
//     body: body,
//     group_id: current_group
//   }
//   $.ajax({
//     url: '/messages',
//     data: { message: message },
//     method: 'POST',
//     success: response => {
//       $('#message_body').val('')
//       // TODO: Load message to chat ...
//     },
//     error: response => {
//       M.toast({ html: response["errors"][0], classes: 'red' })
//     }
//   })
// }

// function add_message(message){
//   console.log(message);
// }

// function load_messages(){
//   const current_group = localStorage.getItem('current-group')
//   $.ajax({
//     url: `/messages?group=${current_group}`,
//     method: 'GET',
//     dataType: 'json',
//     success: response => {
//       const messages = response["messages"]
//       messages.forEach(message => add_message(message))
//     },
//     error: response => {
//       M.toast({ html: response["errors"][0], classes: 'red' })
//     }
//   })
// }
