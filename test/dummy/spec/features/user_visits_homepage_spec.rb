require 'rails_helper'

RSpec.feature "User visits homepage", type: :feature, js: true do
  scenario 'successfully' do
    visit '/'
    expect(page).to have_css 'h1', text: 'Website Home Page'
  end
end
