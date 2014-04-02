function updateSearchValues() {
    function collect(arr, value) {
        var results = [];
        for (var i = 0; i < arr.length; i++) {
            results.push(arr[i][value]);
        }
        return results;
    };
    var availableTags = $.getJSON("/books.json?", {
        query: $("#booksearch").val(),
        format: "JSON",
    }).success(function(data) {
        var titles = $.unique(collect(data,
            "title"));
        $("#booksearch").autocomplete({
            source: titles
        });
    });
};
$(document).ready(function() {
    $("#booksearch").bind('input', function() {
        updateSearchValues();
    });
});