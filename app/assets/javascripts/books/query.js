$(document).ready(function() {
    $("#bookquery").hide();

    $("#wbooksearch").bind('input', function() {
        showValues();
    });
});

function showValues() {
    var bookquery = $("#bookquery");
    if ($("#wbooksearch").val().length >= 3) {

        bookquery.show(500);
        $.ajax({
            url: "welcome/query",
            data: {
                query: $("#wbooksearch").val()
            }
        }).done(function(html) {
            bookquery.empty();

            bookquery.prepend(html);
            $(".setISBN").bind('click', function() {
                $("#bookISBN").val($(this).parent().data("isbn"));
                //Wipe out all selected values and set this one to black.
                $(".bookitem").css('background-color', 'white');
                $(this).parent(".bookitem").css('background-color', 'lightgrey');
            });
        });
    } else {
        $("#bookISBN").val("");
        bookquery.hide(500);
    }
};