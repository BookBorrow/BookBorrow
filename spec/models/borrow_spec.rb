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

  it "sets the duration based on the due date" do
    Date.stub(:today).and_return(Time.parse("Jan 14 2014"))
    borrow = Borrow.new
    binding.pry
    # borrow.due_date=()

  end

end
