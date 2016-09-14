require 'rails_helper'

RSpec.feature "admin account authentication,", type: :feature, js: true do

  scenario 'successfully signs into the dashboard' do
    admin = create(:user, :admin)

    login admin
  end

  scenario 'is routed to the sign in page after signing out' do
    admin = create(:user, :admin)

    login admin
    click_link 'Sign Out'

    expect(page).to have_current_path '/users/sign_in'
    expect(page).to have_css 'h1', text: 'Sign In'
  end

  scenario 'cannot be accesed by a default user type' do
    Rails.application.load_seed 
    visit '/users/sign_up'
    expect(page).to have_css 'h1', text: 'Sign Up'

    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Sign up'

    expect(page).to have_current_path '/'
    expect(page).to_not have_current_path '/o_cms/'
    expect(page).to have_css '.alert p', text: 'Sorry your are not authorized to view this area.'
  end

  scenario 'successfully updates account and stays on the edit page afterwards' do
    admin = create(:user, :admin)

    login admin
    expect(page).to have_css 'h1', text: 'Welcome to Outside CMS'

    click_link admin.email
    expect(page).to have_current_path '/users/edit'
    expect(page).to have_css '.email', visible: admin.email

    fill_in 'Email', with: "newmail@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    fill_in 'Current password', with: "password"
    click_button 'Update'

    expect(page).to have_current_path '/users/edit'
    expect(page).to have_css 'h1', text: 'Edit your account'
    expect(page).to have_css '.email', visible: "newmail@example.com"
  end

  scenario 'registration edit uses the dashboard template' do
    admin = create(:user, :admin)

    login admin
    expect(page).to have_css 'h1', text: 'Welcome to Outside CMS'

    click_link admin.email
    expect(page).to have_current_path '/users/edit'
    expect(page).to have_css 'h1', text: 'Edit your account'
    expect(page).to have_css '.email', visible: admin.email
    expect(page).to have_css 'header.top'

    fill_in 'Email', with: "newmail@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    fill_in 'Current password', with: "password"
    click_button 'Update'

    expect(page).to have_css 'h1', text: 'Edit your account'
    expect(page).to have_css '.email', visible: admin.email
    expect(page).to have_css 'header.top'
  end

  # password
  scenario 'successfully resets password' do
    admin = create(:user, :admin)

    visit '/users/sign_in'
    expect(page).to have_css 'h1', text: 'Sign In'

    click_link 'Forgotten your password?'

    expect(page).to have_current_path '/users/password/new'
    expect(page).to have_css 'h1', text: 'Forgotten your password?'

    fill_in 'Email', with: admin.email
    click_button 'Send me reset instructions'

    expect(page).to have_current_path '/users/sign_in'
    expect(page).to have_css 'h1', text: 'Sign In'

    open_email admin.email, with_subject: "Reset password instructions"
    visit_in_email "Change my password"

    expect(page).to have_css 'h1', text: 'Change your password'
    fill_in 'Password', with: "new-password"
    fill_in 'Password confirmation', with: "new-password"
    click_button 'Change my password'

    expect(page).to have_current_path '/o_cms/'
    expect(page).to have_css 'h1', text: 'Welcome to Outside CMS'
  end
end
