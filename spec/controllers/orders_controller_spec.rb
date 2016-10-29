require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  it "go to create without login, it will redirect to login page" do
    post :create
    expect(response).to redirect_to(login_path)
  end

  it "go to index without login, it will redirect to login page" do
    get :index
    expect(response).to redirect_to(login_path)
  end

end
