$(document).on("turbolinks:load", () => {

  $('#pending-invite-modal').modal();

  const invite_span = $("#pending-invite")
  if (invite_span.length) {
    const invite_id = invite_span.text()
    let pending_invite_modal = document.querySelector("#pending-invite-modal")
    console.log(pending_invite_modal);
    // pending_invite_modal.open()
    var instance = M.Modal.getInstance(pending_invite_modal)
    console.log(instance);
    //$('#pending-invite-modal').open()
    console.log(instance.open())
    // console.log($('#new-team-user-modal').modal('open'))
  }

})
