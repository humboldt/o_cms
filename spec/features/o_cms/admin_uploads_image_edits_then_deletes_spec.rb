require 'rails_helper'

RSpec.feature "User uploads an image", type: :feature, js: true do

  scenario 'successfully signs into the dashboard' do
    admin = create(:user, :admin)

    login admin
  end

  scenario 'is routed to the images page after clicking the navigation link' do
    admin = create(:user, :admin)

    login admin
    click_link 'Library'

    expect(page).to have_current_path '/o_cms/images'
    expect(page).to have_css 'h1', text: 'Library'
    expect(page).to have_css 'h2', text: 'Images'
  end

  scenario 'successfully uploads an image' do
    file = File.absolute_path('./spec/fixtures/files/demo-image.jpg')
    admin = create(:user, :admin)

    login admin
    visit '/o_cms/images'
    click_link 'Add Image'

    expect(page).to have_current_path '/o_cms/images/new'
    expect(page).to have_css 'h2', text: 'New Image'

    fill_in 'Name', with: "Morning View"
    attach_file('image_file', file)
    fill_in 'Description', with: "Picture from my first morning in the alps"
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'mage was saved successfully.'
    expect(page).to have_css 'h2', text: 'Image Preview'
    expect(page).to have_css 'h3', text: 'Morning View'
    expect(page).to have_css 'img.preview'
    expect(page).to have_css 'p', text: 'Picture from my first morning in the alps'
    expect(OCms::Image.count).to eq(1)
  end
end
