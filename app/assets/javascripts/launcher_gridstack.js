function gridstack_params(){
    var options = {
        cellHeight: 100,
        verticalMargin: 20,
        horizontalMargin: 20,
        minWidth: 4,
        resizable: {
            handles: 'e, se, s, sw, w'
        }
    };

    $('.grid-stack').gridstack(options);
}

$(document).ready(function () {
    gridstack_params();
});



