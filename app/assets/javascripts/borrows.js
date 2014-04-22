$(function() {
    $("#borrows").change("#borrow_returned", function() {
        $form = $(this).find("form[id^=edit_borrow]");
        $form.submit();
    });
});
