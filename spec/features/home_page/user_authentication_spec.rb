require 'rails_helper'

RSpec.feature "HomePage::UserAuthentication", type: :feature do
  given!(:user) { User.create(email: "john.doe@gmail.com", password: "password", confirmed_at: Time.now ) }
  scenario "user signs in to our app" do
    visit new_user_session_path

    within "#new_user" do
      fill_in "Email",    with: "john.doe@gmail.com"
      fill_in "Password", with: "password"
    end

    click_button "Sign in"
    expect(page).to have_content "Signed in successfully"
  end
end
