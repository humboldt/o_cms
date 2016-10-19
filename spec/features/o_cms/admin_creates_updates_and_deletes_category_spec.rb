require 'rails_helper'

RSpec.feature "Admin manages categories,", type: :feature, js: true do
  scenario 'is routed to the categories page after clicking the navigation link' do
    admin = create(:user, :admin)

    login admin
    click_link 'Blog'

    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Categories'

    expect(page).to have_current_path '/o_cms/categories'
    expect(page).to have_css 'h1', text: 'Categories'
    expect(page).to have_css 'h2', text: 'Categories'
  end

  scenario 'successfully creates a category' do
    admin = create(:user, :admin)

    login admin
    visit '/o_cms/categories'
    
    expect(page).to have_css 'h1', text: 'Categories'
    expect(page).to have_css 'h2', text: 'Categories'

    click_link 'Add Category'

    expect(page).to have_css 'h2', text: 'New Category'
    expect(page).to have_current_path '/o_cms/categories/new'

    fill_in 'Name', with: "Adventure Cycling Inspiration"
    find(".category_body").set("Top destinations and travel tips for adventure cycling in the UK. Looking for a new destination? Not sure what to pack? Looking for some differnt terrain? You are in the right place, these are some top adventure cycling destination to get you inspired.")
    fill_in 'Icon', with: "flag-icon"
    click_button 'Save'

    expect(page).to have_css 'h2', text: 'Edit Category'
    expect(page).to have_field('Name', with: 'Adventure Cycling Inspiration')
    expect(page).to have_field('Slug', with: 'adventure-cycling-inspiration')
    expect(page).to have_css '.category_body div', text: 'Top destinations and travel tips for adventure cycling in the UK. Looking for a new destination? Not sure what to pack? Looking for some differnt terrain? You are in the right place, these are some top adventure cycling destination to get you inspired.'

    expect(page).to have_css '.alert', text: 'Category was saved successfully.'
  end

  scenario 'successfully edits a category' do
    admin = create(:user, :admin)
    my_category = create(:category)

    login admin
    visit '/o_cms/categories'

    expect(page).to have_css 'h1', text: 'Categories'

    click_link 'Edit'
    expect(page).to have_css 'h2', text: 'Edit Category'
    expect(page).to have_field('Name', with: my_category.name)
    fill_in 'Name', with: "Adventure Cycling Events Calendar"
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Category was updated successfully.'
    expect(page).to have_field('Name', with: 'Adventure Cycling Events Calendar')

    visit '/o_cms/categories'

    expect(page).to have_content 'Adventure Cycling Events Calendar'
  end

  scenario 'successfully deletes a category' do
    admin = create(:user, :admin)
    my_category = create(:category)

    login admin
    visit '/o_cms/categories'

    expect(page).to have_css 'h1', text: 'Categories'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Category'
    expect(page).to have_field('Name', with: my_category.name)

    click_link 'Delete'

    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept

    expect(page).to have_current_path '/o_cms/categories'
    expect(page).to have_css '.alert', text: my_category.name + '" was deleted successfully.'
  end
end
