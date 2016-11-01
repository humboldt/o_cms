require 'rails_helper'

RSpec.feature "Admin creates pages of each status,", type: :feature, js: true do
  scenario 'successfully creates a draft page' do
    admin = create(:user, :admin)
    login admin

    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    click_link 'Add Page'

    expect(page).to have_css 'h2', text: 'New Page'
    expect(page).to have_current_path '/o_cms/pages/new'

    fill_in 'Title', with: "Adventure Cycling Maps"
    find(".page_body").set("The Adventure Cycling Route Network features rural and low-traffic bicycling routes through some of the most scenic and historically significant terrain in the world.")
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Page was saved successfully.'

    visit '/o_cms/pages'

    expect(page).to have_text 'Adventure Cycling Maps'
    expect(page).to have_css '.tag-draft', text: 'Draft'
  end

  scenario 'successfully creates a published page' do
    admin = create(:user, :admin)
    login admin

    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    click_link 'Add Page'

    expect(page).to have_css 'h2', text: 'New Page'
    expect(page).to have_current_path '/o_cms/pages/new'

    freeze_time

    fill_in 'Title', with: "Membership - Join us in Adventure Cycling"
    find(".page_body").set("When you join, you’ll get nine issues chock-full of bicycle-touring tips and inspiring places to ride delivered to your door each year.")
    find('#page_status').find(:xpath, 'option[2]').select_option
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Page was saved successfully.'
    expect(page).to have_css '.alert-published', text: 'Published on'

    visit '/o_cms/pages'

    expect(page).to have_text 'Membership - Join us in Adventure Cycling'
    expect(page).to have_css '.tag-published', text: 'Published'
  end

  scenario 'successfully creates a scheduled page' do
    admin = create(:user, :admin)
    login admin

    click_link 'Pages'

    expect(page).to have_css 'h1', text: 'Pages'
    expect(page).to have_css 'h2', text: 'Pages'
    expect(page).to have_current_path '/o_cms/pages'

    click_link 'Add Page'

    expect(page).to have_css 'h2', text: 'New Page'
    expect(page).to have_current_path '/o_cms/pages/new'

    freeze_time

    fill_in 'Title', with: "Guided cycling tours"
    find(".page_body").set("What are you waiting for? Grab life by the bars and join us in Adventure Cycling in 2017! We create unique experiences for riders of all abilities.")
    find('#page_status').find(:xpath, 'option[3]').select_option
    fill_in 'page_published_at', :with => 2.days.from_now
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Page was saved successfully.'
    expect(page).to have_css '.alert-scheduled', text: 'Scheduled for'

    visit '/o_cms/pages'

    expect(page).to have_text 'Guided cycling tours'
    expect(page).to have_css '.tag-scheduled', text: 'Scheduled'

    # Travel until one second before publish time
    travel_to(2.days.from_now - 1.second) do
      visit '/o_cms/pages'
      expect(page).to have_text 'Guided cycling tours'
      expect(page).to have_css '.tag-scheduled', text: 'Scheduled'
    end

    # Travel until one second after published time
    travel_to(2.days.from_now + 1.second) do
      visit '/o_cms/pages'
      expect(page).to have_text 'Guided cycling tours'
      expect(page).to have_css '.tag-published', text: 'Published'
    end
  end
end
