function updateSearchValues() {
    function collect(arr, value) {
        var results = [];
        for (var i = 0; i < arr.length; i++) {
            results.push(arr[i][value]);
        }
        return results;
    };
    var booksearch = $("#booksearch");
    //Only request if 3 or more characters entered into search
    if (booksearch.val().length >= 3) {
        var availableTags = $.getJSON("/books.json?", {
            query: booksearch.val(),
            format: "JSON",
        }).success(function(data) {
            var titles = $.unique(collect(data,
                "title"));
            booksearch.autocomplete({
                source: titles,
                select: function(event, ui) {
                    window.location.href = "/books?utf8=%E2%9C%93&query=" + ui.item.value + "&commit=search";
                }
            });
        });
    }
};
$(document).ready(function() {
    $("#booksearch").bind('input', function() {
        updateSearchValues();
    });
});