function validate_params() {
    $.extend($.validator.messages, {
        required: I18n.translate('validate_required'),
        maxlength: I18n.translate('validate_maxlength'),
        minlength: I18n.translate('validate_minlength'),
        equalTo: I18n.translate('validate_equalTo'),
        remote: "Please fix this field.",
        email: I18n.translate('validate_email'),
        url: "Please enter a valid URL.",
        date: "Please enter a valid date.",
        dateISO: "Please enter a valid date (ISO).",
        number: "Please enter a valid number.",
        digits: "Please enter only digits.",
        creditcard: "Please enter a valid credit card number.",
        accept: "Please enter a value with a valid extension.",
        rangelength: jQuery.validator.format("Please enter a value between {0} and {1} characters long."),
        range: jQuery.validator.format("Please enter a value between {0} and {1}."),
        max: jQuery.validator.format("Please enter a value less than or equal to {0}."),
        min: jQuery.validator.format("Please enter a value greater than or equal to {0}.")
    });
}

$(document).on('ready', function () {
    validate_params();
    $("#new_user").validate({
        rules: {
            "user[password]" : {
                minlength: 8
            },
            "user[password_confirmation]" : {
                equalTo: "#user_password"
            }
        },
        errorElement: "span",
        highlight: function(element) {
            $(element).wrap("<div class='form-error-container'></div>");
        }
    });

    $("#log-user").validate({
        errorElement: "span",
        highlight: function(element) {
            $(element).wrap("<div class='form-error-container'></div>");
        }
    });

    $("#edit_user").validate({
        rules: {
            "user[password]" : {
                minlength: 8
            },
            "user[password_confirmation]" : {
                equalTo: "#user_password"
            }
        },
        errorElement: "span",
        highlight: function(element) {
            $(element).wrap("<div class='form-error-container'></div>");
        }
    });
});