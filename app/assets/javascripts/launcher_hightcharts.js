function hightchart_params(){
    Highcharts.getOptions().plotOptions.pie.colors = (function () {
        var colors = ['#00D6F1', '#3299E8', '#71DA3A', '#FF74C0', '#B77BE8']
        return colors
    });
}

$(document).on('ready', function () {
    hightchart_params();
});



