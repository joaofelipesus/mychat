import consumer from "./consumer"
import Message  from '../packs/messages/lib'

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const current_user = $('#current-user').text()
    if (current_user != data.user_id)
      Message.add(data)
  }
});
