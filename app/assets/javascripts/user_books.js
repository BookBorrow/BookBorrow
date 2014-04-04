$(function(){
  $('#new_borrow_submit').click(function(){
    $form = $("form#new_borrow");
    $form.submit();
  });

  $('.loanable-button').click(function(e){
    //e.preventDefault();
    $('#myModal').modal();
  });

});


