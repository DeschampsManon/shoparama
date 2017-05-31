$(document).ready(function(){
    edit_user_live_edit();
})

function edit_user_live_edit() {
    $("#edit_user input").keyup(function () {
        input_value = $(this).val();
        input_id = $(this).attr("id");
        console.log(input_id);
        $("#page-header [data-id='"+input_id+"']").html(input_value);
    })
}