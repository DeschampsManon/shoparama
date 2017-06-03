$(document).on('ready', function () {
    dataConfirmModal.setDefaults({
        title: I18n.translate('confirm_destroy_title'),
        commit: I18n.translate('confirm_destroy_accept'),
        cancel: I18n.translate('confirm_destroy_refuse')
    });
})