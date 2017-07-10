tfunction datatable_params(){
    $.extend( true, $.fn.dataTable.defaults, {
        responsive: true,
        "language" : {
            lengthMenu:   I18n.translate('datatable_lengthMenu'),
            search:         '<span class="label">'+I18n.translate('datatable_search')+'</span>',
            info:           I18n.translate('datatable_info'),
            zeroRecords:    I18n.translate('datatable_zeroRecords'),
            infoEmpty:      I18n.translate('datatable_infoEmpty'),
            paginate: {
                previous:   '< '+I18n.translate('datatable_previous'),
                next:       I18n.translate('datatable_next')+' >',
            },
        },
        stateSave: true
    } );

    $(".datatable").dataTable();
}

$(document).on('ready', function () {
    datatable_params();
});



