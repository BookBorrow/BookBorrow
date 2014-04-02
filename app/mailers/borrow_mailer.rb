class BorrowMailer < ActionMailer::Base
  default from: "michael.prouty@flatironschool.com"

  def reminder_email(borrow)
    @borrow = borrow
    @lender = borrow.user_book.user
    @book = borrow.user_book.book

    message = mail(to: "michael.prouty@gmail.com", subject: "Testing 123")
  end
end
