class BorrowMailer < ActionMailer::Base
  default from: "michael.prouty@flatironschool.com"

  def reminder_email(borrow)
    @borrow = borrow
    @lender = borrow.user_book.user
    @book = borrow.user_book.book

    message = mail(to: @borrow.borrower_email, subject: "Overdue Book: #{@book.title}")
  end
end
