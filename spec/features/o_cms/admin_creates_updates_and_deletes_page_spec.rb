require 'rails_helper'

RSpec.feature "Admin manages pages,", type: :feature, js: true do
  scenario 'is routed to the pages index page after clicking the navigation link' do
    admin = create(:user, :admin)

    login admin
    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'
  end

  scenario 'successfully creates a page' do
    admin = create(:user, :admin)

    login admin
    visit '/o_cms/pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'

    click_link 'Add Page'

    expect(page).to have_css 'h2', text: 'New Page'
    expect(page).to have_current_path '/o_cms/pages/new'

    fill_in 'Title', with: "About Adventure Cycling Daily"
    find(".page_body").set("Our goal is to deliver a daily source of adventure cycling news and events to keep you planning for your next trip. Our mission is to inspire and empower people to travel by bicycle.")
    fill_in 'Excerpt', with: "Inspiring and empowering people to travel by bicycle."
    find('#page_status').find(:xpath, 'option[2]').select_option

    click_button 'Save'

    expect(page).to have_css 'h2', text: 'Edit Page'
    expect(page).to have_field('Title', with: 'About Adventure Cycling Daily')
    expect(page).to have_field('Slug', with: 'about-adventure-cycling-daily')
    expect(page).to have_css '.page_body', text: 'Our goal is to deliver a daily source of adventure cycling news and events to keep you planning for your next trip. Our mission is to inspire and empower people to travel by bicycle.'
    expect(page).to have_field('Excerpt', with: 'Inspiring and empowering people to travel by bicycle.')
    expect(page).to have_css '.alert', text: 'Page was saved successfully.'
  end

  scenario 'successfully edits a page' do
    admin = create(:user, :admin)
    page_to_update = create(:page)

    login admin
    visit '/o_cms/pages'

    expect(page).to have_css 'h1', text: 'Pages'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Page'
    expect(page).to have_field('Title', with: page_to_update.title)

    fill_in 'Title', with: "Epic Tours - Expore the world by bike"
    find(".page_body").set("Bicycling across a continent is less about athleticism and more about spirit and perseverance, the capacity to roll with the bumps along the way. Having successfully done it says something about a person’s character.")
    fill_in 'Excerpt', with: "Someday, I’m going for it — the big one, the moon shot. A 21- to 93-day, self-contained or van-supported adventure by bike."
    find('#page_status').find(:xpath, 'option[2]').select_option

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Page was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Page'
    expect(page).to have_field('Title', with: 'Epic Tours - Expore the world by bike')
    expect(page).to have_field('Slug', with: 'epic-tours')
    expect(page).to have_css '.page_body', text: 'Bicycling across a continent is less about athleticism and more about spirit and perseverance, the capacity to roll with the bumps along the way. Having successfully done it says something about a person’s character.'
    expect(page).to have_field('Excerpt', with: 'Someday, I’m going for it — the big one, the moon shot. A 21- to 93-day, self-contained or van-supported adventure by bike.')

    visit '/o_cms/pages'

    expect(page).to have_content 'Epic Tours - Expore the world by bike'
  end

  scenario 'successfully deletes a page' do
    admin = create(:user, :admin)
    page_to_delete = create(:page)

    login admin
    visit '/o_cms/pages'

    expect(page).to have_css 'h1', text: 'Pages'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Page'
    expect(page).to have_field('Title', with: page_to_delete.title)

    click_link 'Delete'

    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept

    expect(page).to have_css '.alert', text: page_to_delete.title + '" was deleted successfully.'
    expect(page).to have_current_path '/o_cms/pages'
  end
end
