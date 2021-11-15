require 'rails_helper'

RSpec.feature "HomePage::UserRegistration", type: :feature do
  scenario "user registers to our app" do
    visit "/"

    expect(page).to have_link("Register")
  end
end
