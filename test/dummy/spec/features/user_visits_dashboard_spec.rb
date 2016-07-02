require 'rails_helper'

RSpec.feature "User visits dashboard", type: :feature, js: true do
  
  scenario 'successfully' do
    visit '/o_cms'
    expect(page).to have_css 'h1', text: 'Welcome to Outside CMS'
  end
end