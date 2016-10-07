require 'rails_helper'

RSpec.feature "Admin creates a post", type: :feature, js: true do

  scenario 'successfully creates a draft post' do
    admin = create(:user, :admin)
    login admin

    click_link 'Blog'
    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Add Post'
    expect(page).to have_current_path '/o_cms/posts/new'
    expect(page).to have_css 'h2', text: 'New Post'

    fill_in 'Title', with: "Configurable by design"
    fill_in 'Body', with: "Picture from my first morning in the alps"
    click_button 'Save'

    expect(OCms::Post.last.title).to eq 'Configurable by design'
    expect(OCms::Post.last.status).to eq 'draft'
  end

  scenario 'successfully creates a published post' do
    admin = create(:user, :admin)
    login admin

    click_link 'Blog'
    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Add Post'
    expect(page).to have_current_path '/o_cms/posts/new'
    expect(page).to have_css 'h2', text: 'New Post'

    freeze_time

    fill_in 'Title', with: "Configurable by design"
    fill_in 'Body', with: "Picture from my first morning in the alps"
    find('#post_status').find(:xpath, 'option[2]').select_option
    click_button 'Save'

    expect(OCms::Post.last.title).to eq 'Configurable by design'
    expect(OCms::Post.last.status).to eq 'published'
    expect(OCms::Post.last.published_at).to eq(Time.current)
  end

  scenario 'successfully creates a scheduled post' do
    admin = create(:user, :admin)
    login admin

    click_link 'Blog'
    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Add Post'
    expect(page).to have_current_path '/o_cms/posts/new'
    expect(page).to have_css 'h2', text: 'New Post'

    # Fill in the post with a sceduled future date
    freeze_time

    fill_in 'Title', with: "Configurable by design"
    fill_in 'Body', with: "Picture from my first morning in the alps"
    find('#post_status').find(:xpath, 'option[3]').select_option
    fill_in 'Body', with: "Picture from my first morning in the alps"
    fill_in 'post_published_at', :with => Time.new(2016, 10, 24, 12, 20, 00)
    click_button 'Save'

    # Expect the post to be scheduled for the published at time.
    expect(OCms::Post.last.title).to eq 'Configurable by design'
    expect(OCms::Post.last.status).to eq 'scheduled'
    expect(OCms::Post.last.published_at).to eq(Time.new(2016, 10, 24, 12, 20, 00))

    # Travel until one second before
    travel_to(Time.new(2016, 10, 24, 12, 19, 59)) do
      expect(OCms::Post.last.title).to eq 'Configurable by design'
      expect(OCms::Post.last.status).to eq 'scheduled'
      expect(OCms::Post.last.published_at).to eq(Time.new(2016, 10, 24, 12, 20, 00))
    end

    # Travel to the exact time
    travel_to(Time.new(2016, 10, 24, 12, 20, 00)) do
      expect(OCms::Post.last.title).to eq 'Configurable by design'
      expect(OCms::Post.last.status).to eq 'published'
      expect(OCms::Post.last.published_at).to eq(Time.new(2016, 10, 24, 12, 20, 00))
    end
  end
end
