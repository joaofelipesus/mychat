$(document).on("turbolinks:load", () => {

    $(document).ready(function(){
        $('select').formSelect();
    });

    $('#new-team-user-form').on('ajax:success', response => {
        [data, status, xhr] = response.detail
        M.toast({ html: 'Invite sent', classes: 'green' })
        var instance = M.Modal.getInstance($('#new-team-user-modal'));
        instance.close()
    })

    $('#new-team-user-form').on('ajax:error', response => {
        let errors = response.detail[0]
        M.toast({ html: errors["errors"][0], classes: 'red' })
    })

})
