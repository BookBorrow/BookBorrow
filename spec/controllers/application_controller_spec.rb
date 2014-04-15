require 'spec_helper'
describe ApplicationController do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  before (:each) do
    @user = create(:user)
  end

  describe "After sigin-in" do
    it "redirects to the /jobs page" do
      controller.after_sign_in_path_for(@user).should == "/"
    end
  end

  it "should redirect to signin_path" do
    controller.should_receive(:redirect_to).with(new_user_session_path, {:alert=>"Please sign in."})
    controller.send(:require_signin)
  end
end
