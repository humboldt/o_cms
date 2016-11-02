require 'rails_helper'

RSpec.feature "Admin manages galleries,", type: :feature, js: true do
  scenario 'is routed to the galleries index page after clicking the navigation link' do
    admin = create(:user, :admin)

    login admin
    click_link 'Library'

    expect(page).to have_css 'h1', text: 'Library'
    expect(page).to have_css 'h2', text: 'Images'

    click_link 'Galleries'

    expect(page).to have_css 'h1', text: 'Library'
    expect(page).to have_css 'h2', text: 'Galleries'
    expect(page).to have_current_path '/o_cms/galleries'
  end

  scenario 'successfully creates a page' do
    admin = create(:user, :admin)
    image = create(:image)
    second_image = create(:forest_image)

    login admin
    visit '/o_cms/galleries'

    expect(page).to have_css 'h1', text: 'Library'
    expect(page).to have_css 'h2', text: 'Galleries'

    click_link 'Add Gallery'

    expect(page).to have_css 'h2', text: 'New Gallery'
    expect(page).to have_current_path '/o_cms/galleries/new'
    expect(page).to within(:css, '.gallery-options') { have_xpath(".//img[@src=\"#{image.file.admin_thumb}\"]") }
    expect(page).to within(:css, '.gallery-options') { have_xpath(".//img[@src=\"#{second_image.file.admin_thumb}\"]") }

    fill_in 'Name', with: "Coast to coast, four day adventure"
    fill_in 'Description', with: "We were not blessed with the best weather but take a look at our trip photos."
    find("img[alt='#{image.name}']").click

    expect(page).to within(:css, 'span.selected') { have_xpath(".//img[@src=\"#{image.file.admin_thumb}\"]") }

    click_button 'Save'

    expect(page).to have_css 'h2', text: 'Edit Gallery'
    expect(page).to have_field('Name', with: 'Coast to coast, four day adventure')
    expect(page).to have_field('Description', with: 'We were not blessed with the best weather but take a look at our trip photos.')
    expect(page).to within(:css, 'span.selected') { have_xpath(".//img[@src=\"#{image.file.admin_thumb}\"]") }

    expect(page).to have_css '.alert', text: 'Gallery was saved successfully.'
  end

  scenario 'successfully edits a gallery' do
    admin = create(:user, :admin)
    image = create(:image)
    second_image = create(:forest_image)
    gallery = create(:gallery)

    login admin
    visit '/o_cms/galleries'

    expect(page).to have_css 'h1', text: 'Library'
    expect(page).to have_css 'h2', text: 'Galleries'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Gallery'
    expect(page).to have_field('Name', with: gallery.name)

    fill_in 'Name', with: "Pictures from our recent cycling trip"
    fill_in 'Description', with: "With only basic supplies you can have alot of fun on a bike."
    find("img[alt='#{image.name}']").click

    expect(page).to within(:css, 'span.selected') { have_xpath(".//img[@src=\"#{image.file.admin_thumb}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Gallery was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Gallery'
    expect(page).to have_field('Name', with: 'Pictures from our recent cycling trip')
    expect(page).to have_field('Description', with: 'With only basic supplies you can have alot of fun on a bike.')
    expect(page).to within(:css, 'span.selected') { have_xpath(".//img[@src=\"#{image.file.admin_thumb}\"]") }

    find("img[alt='#{image.name}']").click
    find("img[alt='#{second_image.name}']").click

    expect(page).to within(:css, 'span.selected') { have_xpath(".//img[@src=\"#{second_image.file.admin_thumb}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Gallery was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Gallery'
    expect(page).to have_field('Name', with: 'Pictures from our recent cycling trip')
    expect(page).to have_field('Description', with: 'With only basic supplies you can have alot of fun on a bike.')
    expect(page).to within(:css, 'span.selected') { have_xpath(".//img[@src=\"#{second_image.file.admin_thumb}\"]") }

    visit '/o_cms/galleries'

    expect(page).to have_content 'Pictures from our recent cycling trip'
  end

  scenario 'successfully deletes a gallery' do
    admin = create(:user, :admin)
    gallery = create(:gallery)

    login admin
    visit '/o_cms/galleries'

    expect(page).to have_css 'h1', text: 'Library'
    expect(page).to have_css 'h2', text: 'Galleries'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Gallery'
    expect(page).to have_field('Name', with: gallery.name)

    click_link 'Delete'

    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept

    expect(page).to have_css '.alert', text: gallery.name + '" was deleted successfully.'
    expect(page).to have_current_path '/o_cms/galleries'
  end
end
