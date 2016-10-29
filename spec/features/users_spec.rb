require 'rails_helper'

RSpec.feature "Users", type: :feature do
  before(:each) { @user = User.create(email: 'a@a.com', name: 'A Test', password: '1234') }
  after(:all) { User.delete_all }

  it "User can create new account" do
    visit signup_path
    fill_in "user_name", :with => "Test"
    fill_in "user_email", :with => "test@test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    click_button "Create Account"

    expect(page).to have_content "Account created."
  end

  it "User can not create new account with blank password" do
    visit signup_path
    fill_in "user_name", :with => "Test"
    fill_in "user_email", :with => "test@test.com"
    fill_in "user_password", :with => ""
    fill_in "user_password_confirmation", :with => "test"
    click_button "Create Account"

    expect(page).to have_content "Password can't be blank"
  end

  it "User can not create new account with blank name" do
    visit signup_path
    fill_in "user_name", :with => ""
    fill_in "user_email", :with => "test@test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    click_button "Create Account"

    expect(page).to have_content "Name can't be blank"
  end

  it "User can not create new account with blank email" do
    visit signup_path
    fill_in "user_name", :with => "Test"
    fill_in "user_email", :with => ""
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    click_button "Create Account"

    expect(page).to have_content "Email can't be blank"
  end

  it "User can not create new account with password and password confirmation is not match" do
    visit signup_path
    fill_in "user_name", :with => "Test"
    fill_in "user_email", :with => "test@test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test1"
    click_button "Create Account"

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it "User can not login if not registed" do
    visit login_path
    fill_in "email", :with => "a@b.com"
    fill_in "password", :with => "1234"
    click_button "Log In"

    expect(page).to have_content "User not found."
  end

  scenario 'user cannot sign in with wrong email' do
    visit login_path
    fill_in "email", :with => "b@b.com"
    fill_in "password", :with => @user.password
    click_button "Log In"

    expect(page).to have_content "User not found."
  end

  scenario 'user cannot sign in with wrong password' do
    visit login_path
    fill_in "email", :with => @user.email
    fill_in "password", :with => "12345"
    click_button "Log In"

    expect(page).to have_content "Incorrect password."
  end

  it "user can sign in with valid credentials" do
    visit login_path
    fill_in "email", :with => @user.email
    fill_in "password", :with => @user.password
    click_button "Log In"

    expect(page).to have_content "Login successfully."
  end
end
