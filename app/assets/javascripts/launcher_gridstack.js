function gridstack_params() {
    var options = {
        cellHeight: 100,
        verticalMargin: 20,
        horizontalMargin: 20,
        minWidth: 4,
        resizable: {
            handles: 'e, se, s, sw, w'
        }
    };

    $('#grid-stack').gridstack(options);
}

function gridstack_save_position(event, items) {
    this.serializedData = _.map($('.grid-stack > .grid-stack-item:visible'), function (el) {
        var el = $(el);
        var node = el.data('_gridstack_node');
        return {
            id: el.data('id'),
            x: node.x,
            y: node.y,
            width: node.width,
            height: node.height
        };
    });

    $.ajax({
        url: "/admin/dashboards/change_block_chart",
        type: "post",
        dataType: "json",
        data: {data: JSON.stringify(this.serializedData)}
    });

    $(".chart-container").each(function(){
        $(this).highcharts().reflow();
    });
}

$(document).ready(function () {
    gridstack_params();
    $("#grid-stack").on('change', gridstack_save_position);
});
