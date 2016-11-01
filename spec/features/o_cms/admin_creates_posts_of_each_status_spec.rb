require 'rails_helper'

RSpec.feature "Admin creates posts of each status type,", type: :feature, js: true do
  scenario 'successfully creates a draft post' do
    admin = create(:user, :admin)
    login admin

    click_link 'Blog'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'
    expect(page).to have_current_path(o_cms.posts_path)

    click_link 'Add Post'

    expect(page).to have_css 'h2', text: 'New Post'
    expect(page).to have_current_path '/o_cms/posts/new'

    fill_in 'Title', with: "Tremola (2,091m) - Paris-Roubaix of the Alps"
    find(".post_body").set("It was little surprise to see the south side of Gotthard Pass, also called the Tremola, top the vote. The 7.3-mile climb has an average gradient of eight per cent and the top five kilometres are cobbled.")

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'

    visit '/o_cms/posts'

    expect(page).to have_text 'Tremola (2,091m) - Paris-Roubaix of the Alps'
    expect(page).to have_css '.tag-draft', text: 'Draft'
  end

  scenario 'successfully creates a published post' do
    admin = create(:user, :admin)
    login admin

    click_link 'Blog'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'
    expect(page).to have_current_path '/o_cms/posts'

    click_link 'Add Post'

    expect(page).to have_css 'h2', text: 'New Post'
    expect(page).to have_current_path '/o_cms/posts/new'

    freeze_time

    fill_in 'Title', with: "Furka Pass (2,436m) - Pure switchback glory"
    find(".post_body").set("Go down the north side of the Gotthard Pass and take a left in Hospental: you are now climbing the Furka. The fourth highest Swiss pass is famous for its big views and the stone pillars which line its many switchbacks.")
    find('#post_status').find(:xpath, 'option[2]').select_option
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'
    expect(page).to have_css '.alert-published', text: 'Published on'

    visit '/o_cms/posts'

    expect(page).to have_text 'Furka Pass (2,436m) - Pure switchback glory'
    expect(page).to have_css '.tag-published', text: 'Published'
  end

  scenario 'successfully creates a scheduled post' do
    admin = create(:user, :admin)
    login admin

    click_link 'Blog'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'
    expect(page).to have_current_path(o_cms.posts_path)

    click_link 'Add Post'

    expect(page).to have_css 'h2', text: 'New Post'
    expect(page).to have_current_path '/o_cms/posts/new'

    freeze_time

    fill_in 'Title', with: "Nufenen (2,478m) - A long day in the mountains"
    find(".post_body").set("Nufenen (the second highest paved pass in Switzerland) is a beast: it climbs 1,108m in less than eight miles. While this makes an average of 8.5 per cent, there are several long sections above ten per cent.")
    find('#post_status').find(:xpath, 'option[3]').select_option
    fill_in 'post_published_at', :with => 2.days.from_now
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'
    expect(page).to have_css '.alert-scheduled', text: 'Scheduled for'

    visit '/o_cms/posts'
    expect(page).to have_text 'Nufenen (2,478m) - A long day in the mountains'
    expect(page).to have_css '.tag-scheduled', text: 'Scheduled'

    # Travel until one second before publish time
    travel_to(2.days.from_now - 1.second) do
      visit '/o_cms/posts'
      expect(page).to have_text 'Nufenen (2,478m) - A long day in the mountains'
      expect(page).to have_css '.tag-scheduled', text: 'Scheduled'
    end

    # Travel until one second after published time
    travel_to(2.days.from_now + 1.second) do
      visit '/o_cms/posts'
      expect(page).to have_text 'Nufenen (2,478m) - A long day in the mountains'
      expect(page).to have_css '.tag-published', text: 'Published'
    end
  end
end
