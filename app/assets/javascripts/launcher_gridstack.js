function gridstack_params(){
    var options = {
        cellHeight: 80,
        verticalMargin: 10
    };

    $('.grid-stack').gridstack(options);
}

$(document).on('ready', function () {
    gridstack_params();
});



