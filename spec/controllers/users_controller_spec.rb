require 'spec_helper'

describe UsersController do
  it "renders the show template for a user" do
    @user = create(:user)
    get :show, id: @user.id
    expect(response).to render_template("show")
  end
end
