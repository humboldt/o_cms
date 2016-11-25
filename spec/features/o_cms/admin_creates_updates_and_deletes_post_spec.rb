require 'rails_helper'

RSpec.feature "Admin manages posts,", type: :feature, js: true do
  scenario 'is routed to the posts page after clicking the navigation link' do
    admin = create(:user, :admin)

    login admin
    click_link 'Blog'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'
    expect(page).to have_current_path (o_cms.posts_path)
  end

  scenario 'successfully creates a post' do
    admin = create(:user, :admin)

    login admin
    visit '/o_cms/posts'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Add Post'

    expect(page).to have_css 'h2', text: 'New Post'
    expect(page).to have_current_path '/o_cms/posts/new'

    fill_in 'Title', with: "Mindset Tweaks To Enhance Your Time In The Saddle"
    find(".post_body").set("Positive feelings are one of the key components of well being. Having fun and enjoying oneself, in addition to feeling good, has also been associated with improved health, personal efficiency, and productivity, and a bunch of other good things like hopefulness and creativity. Plus, when you’re happily enjoying yourself, it makes it easier for other people to feel good.")
    fill_in 'Excerpt', with: "Positive feelings are one of the key components of well being."

    click_button 'Save'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: 'Mindset Tweaks To Enhance Your Time In The Saddle')
    expect(page).to have_field('Slug', with: 'mindset-tweaks-to-enhance-your-time-in-the-saddle')
    expect(page).to have_css '.post_body', text: 'Positive feelings are one of the key components of well being. Having fun and enjoying oneself, in addition to feeling good, has also been associated with improved health, personal efficiency, and productivity, and a bunch of other good things like hopefulness and creativity. Plus, when you’re happily enjoying yourself, it makes it easier for other people to feel good.'
    expect(page).to have_field('Excerpt', with: 'Positive feelings are one of the key components of well being.')

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'
  end

  scenario 'successfully edits a post' do
    admin = create(:user, :admin)
    post_to_update = create(:post)

    login admin
    visit '/o_cms/posts'

    expect(page).to have_css 'h1', text: 'Blog'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post_to_update.title)

    fill_in 'Title', with: "Adventure Cycling what to pack"
    find(".post_body").set("You have spent months dreaming and planning your bike journey. You have poured over maps and shopped for gear. You have been training hard and saving up. There is a frantic joy/dread to those final hours before you set out on a journey. Life never seems so hectic as those last couple of days before a big bike trip. What did you forget? Is that bike box overweight? Are you bringing too much stuff?")
    fill_in 'Excerpt', with: "Packing advice for the first time traveler. Life never seems so hectic as those last couple of days before a big bike trip."

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_field('Title', with: 'Adventure Cycling what to pack')
    expect(page).to have_css '.post_body', text: 'You have spent months dreaming and planning your bike journey. You have poured over maps and shopped for gear. You have been training hard and saving up. There is a frantic joy/dread to those final hours before you set out on a journey. Life never seems so hectic as those last couple of days before a big bike trip. What did you forget? Is that bike box overweight? Are you bringing too much stuff?'
    expect(page).to have_field('Excerpt', with: 'Packing advice for the first time traveler. Life never seems so hectic as those last couple of days before a big bike trip.')

    visit '/o_cms/posts'

    expect(page).to have_content 'Adventure Cycling what to pack'
  end

  scenario 'successfully deletes a post' do
    admin = create(:user, :admin)
    post_to_delete = create(:post)

    login admin
    visit '/o_cms/posts'

    expect(page).to have_css 'h1', text: 'Blog'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post_to_delete.title)

    click_link 'Delete'

    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept

    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css '.alert', text: post_to_delete.title + '" was deleted successfully.'
  end
end
