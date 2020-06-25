$(document).on('turbolinks:load', () => {

  const current_group_id = $('#current-group').attr('data-value')
  localStorage.setItem('current-group', current_group_id)

})
