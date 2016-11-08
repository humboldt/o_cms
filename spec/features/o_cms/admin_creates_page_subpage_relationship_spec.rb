require 'rails_helper'

RSpec.feature "Admin manages page subpages, ", type: :feature, js: true do
  scenario 'successfully creates a subpage' do
    admin = create(:user, :admin)
    page_parent = create(:page)

    login admin

    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    click_link 'Add Page'

    expect(page).to have_css 'h2', text: 'New Page'
    expect(page).to have_current_path '/o_cms/pages/new'
    expect(page).to have_css('option', text: page_parent.title)

    fill_in 'Title', with: "Adventure Cycling Maps"
    find(".page_body").set("The Adventure Cycling Route Network features rural and low-traffic bicycling routes through some of the most scenic and historically significant terrain in the world.")
    select(page_parent.title, :from => 'page_parent_id')

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Page was saved successfully.'
    expect(page).to have_select 'page_parent_id', selected: page_parent.title

    visit '/o_cms/pages'

    within(:css, 'tr.page-2 td.title') {
      expect(page).to have_text 'Adventure Cycling Maps'
      expect(page).to have_css('i.subpage')
    }
  end

  scenario 'successfully changes subpage parent page' do
    admin = create(:user, :admin)
    page_parent = create(:subscribe_page)
    new_page_parent = create(:about_page)
    subpage = create(:page, parent_id: page_parent.id)

    login admin

    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    within(:css, 'tr.page-' + subpage.id.to_s) {
      click_link 'Edit'
    }

    expect(page).to have_field('Title', with: subpage.title)
    expect(page).to have_select 'page_parent_id', selected: page_parent.title

    select(new_page_parent.title, :from => 'page_parent_id')
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Page was updated successfully.'
    expect(page).to have_select 'page_parent_id', selected: new_page_parent.title

    visit '/o_cms/pages'

    within(:css, 'tr.page-' + subpage.id.to_s + ' td.title') {
      expect(page).to have_text subpage.title
      expect(page).to have_css('i.subpage')
    }
  end

  scenario 'successfully deletes subpage parent page' do
    admin = create(:user, :admin)
    page_parent = create(:subscribe_page)
    subpage = create(:page, parent_id: page_parent.id)

    login admin

    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    within(:css, 'tr.page-' + subpage.id.to_s) {
      click_link 'Edit'
    }

    expect(page).to have_field('Title', with: subpage.title)
    expect(page).to have_select 'page_parent_id', selected: page_parent.title

    within(:css, '.primary-nav') {
      click_link 'Pages'
    }

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    within(:css, 'tr.page-' + page_parent.id.to_s) {
      click_link 'Edit'
    }

    expect(page).to have_field('Title', with: page_parent.title)

    click_link 'Delete'

    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept

    expect(page).to have_css '.alert', text: page_parent.title + '" was deleted successfully.'
    expect(page).to have_current_path '/o_cms/pages'

    within(:css, 'table') {
      expect(page).to_not have_content(page_parent.title)
    }
    within(:css, 'tr.page-' + subpage.id.to_s + ' td.title') {
      expect(page).to have_text subpage.title
      expect(page).to_not have_css('i.subpage')
    }
  end
end
