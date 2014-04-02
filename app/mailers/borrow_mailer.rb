class BorrowMailer < ActionMailer::Base
  default from: "from@example.com"

  def reminder_email(borrow)
    mail(to: "michael.prouty@example.com")
  end
end
