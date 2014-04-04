class BorrowMailer < ActionMailer::Base
  default from: "alex.patriquin@flatironschool.com"

  def reminder_email(borrow)
    @borrow = borrow
    @lender = borrow.user_book.user
    @book = borrow.user_book.book
    puts "Mailed an e-mail"
    message = mail(to: @borrow.borrower_email, subject: "Overdue Book: #{@book.title}")
  end
end
