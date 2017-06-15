$(document).on('ready', function () {
    edit_user_live_edit();
    $( ".select2" ).select2();
    $(".filter-by-category").change(product_categories_filter);
})

function edit_user_live_edit() {
    $(".live-edit-form input").keyup(function () {
        input_value = $(this).val();
        input_id = $(this).attr("id");
        $("#page-header [data-id='"+input_id+"']").html(input_value);
    })

    $(".live-edit-form .file-upload-container input").change(function () {
        var $element = $(this)[0];
        var $element_label = $(this).parent().find("label")
        var $element_preview = $("#user-data [data-id='avatar']");
        var ext = $element.files[0]['name'].substring($element.files[0]['name'].lastIndexOf('.') + 1).toLowerCase();
        if ($element.files && $element.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $element_preview.attr('src', e.target.result);
            }
            $element_label.html($element.files[0]['name']);
            reader.readAsDataURL($element.files[0]);
            $element_label.removeClass("error")
        } else {
            $element_label.html(I18n.translate('form_file_error_format'));
            $element_label.addClass("error")
        }
    });
}

function product_categories_filter() {
    $("#product-filter").submit();
}