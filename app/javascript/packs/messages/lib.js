const COLORS = ['blue-text', 'deep-purple-text darken-1', 'teal-text darken-3', 'brown-text darken-1']

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
    if (current_user == message.user_id){
      message_element = `
        <div class='message right-align'>
          ${message.body}
        </div>`
    }else{
      message_element = `
        <div class="message">
          <span class='login-${message.user_id}'>${message.user.name}:</span>
          ${message.body}
        </div>`
    }
    $('#chat').append(message_element)
    let login_color_relation = $('#login-color-relation')
    if(login_color_relation.length > 0){
      let relation = JSON.parse($('#login-color-relation').text())
      if (`login-${message.user_id}` in relation){
        $(`.login-${message.user_id}`).addClass(relation[`login-${message.user_id}`])
      }else{
        relation[`login-${message.user_id}`] = COLORS[Object.keys(relation).length]
        $('#login-color-relation').text(JSON.stringify(relation))
      }
    }else{
      $('body').append(`<span id='login-color-relation' hidden></span>`)
      let relation = {}
      relation[`login-${message.user_id}`] = COLORS[0]
      $('#login-color-relation').text(JSON.stringify(relation))
      $(`.login-${message.user_id}`).addClass(COLORS[0])
    }
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
