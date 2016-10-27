require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { @user = User.new(email: 'a@a.com', name: 'A Test') }
  after(:all) { User.delete_all }

  it "email return a string" do
    expect(@user.email).to eq "a@a.com"
  end

  it "name return a string" do
    expect(@user.name).to eq "A Test"
  end
end
