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

  it "can find the book's owner" do
    pending
  end

end
