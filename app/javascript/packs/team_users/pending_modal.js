$(document).on("turbolinks:load", () => {

  $('.modal').modal();

  $.ajax({
    url: '/team_users',
    dataType: 'json',
    success: response => {
      console.log(response);
      const invite = response["team_user"]
      $("#team-invite-slug").text(invite["team"]["slug"])
       $('#modal1').modal('open');
    },
    error: error => {
      console.log(error);
    }
  })

})
