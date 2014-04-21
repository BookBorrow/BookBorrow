require 'spec_helper'

describe Borrow do
  it "sets the borrow date to today as a default" do
    borrow = build(:borrow)
    borrow.borrow_date = nil
    expect(borrow.save).to eq(true)
  end

  it "sets the due date based on the borrow duration" do
    borrow = build(:borrow)
    borrow.save
    expect(borrow.due_date).to eq(borrow.borrow_date+7.days)
  end

  it "knows when it is overdue" do
    b = build(:borrow)
    b.borrow_date = Time.now-30.days
    expect(b.overdue?).to eq(true)
  end

  it "can find the book's owner and its book" do
    @book = create(:book)
    @user = create(:user)
    @user2 = create(:user)
    #create entry in user_books
    @user.books << @book

    #create borrow on user_book
    @borrow = @user.user_books.first.borrows.create({
                                            :borrower_email => @user2.email,
                                            :borrower_name => @user2.name,
                                            :duration_in_days => 3,
                                            :borrow_date => Date.today
    })

    @borrow.user.should eq (@user)
    @borrow.book.should eq (@book)
  end

end
