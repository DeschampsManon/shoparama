function toggle_block_chart(e) {
    e.preventDefault();
    var $target =  $(this).closest(".grid-stack-item").find(".grid-stack-item-content");
    $target.slideToggle(400, function(){
        if($target.is(":hidden")){
            $("#toggle-block-chart i").addClass("ion-arrow-down-b").removeClass("ion-arrow-up-b");
        } else {
            $("#toggle-block-chart i").addClass("ion-arrow-up-b").removeClass("ion-arrow-down-b")
        }
    });
}

$(document).ready(function(){
    $("#toggle-block-chart").click(toggle_block_chart);
})