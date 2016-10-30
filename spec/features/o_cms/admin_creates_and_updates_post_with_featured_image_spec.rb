require 'rails_helper'

RSpec.feature "Admin managed featured image in a post,", type: :feature, js: true do
  scenario 'successfully opens and closes featured modal using the select image button and featured modal close button' do
    admin = create(:user, :admin)
    my_post = create(:post)

    login admin
    visit '/o_cms/posts'
    click_link 'Edit'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Edit Post'

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')

    find('button.featured-image').click

    expect(page).to have_css('#featuredModal', visible: true)
    expect(page).to have_css 'h4#featuredModalLabel', text: 'Featured Image'

    find('.modal-header button.close').click

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')
  end

  scenario 'successfully creates a post with a featured image' do
    admin = create(:user, :admin)
    my_image = create(:image)

    login admin
    visit '/o_cms/posts'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Add Post'

    expect(page).to have_css 'h2', text: 'New Post'
    expect(page).to have_current_path '/o_cms/posts/new'

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')
    expect(page).to_not have_css('img#featured_image')

    fill_in 'Title', with: "Mindset Tweaks To Enhance Your Time In The Saddle"
    find(".post_body").set("Positive feelings are one of the key components of well being. Having fun and enjoying oneself, in addition to feeling good, has also been associated with improved health, personal efficiency, and productivity, and a bunch of other good things like hopefulness and creativity. Plus, when you’re happily enjoying yourself, it makes it easier for other people to feel good.")
    fill_in 'Excerpt', with: "Positive feelings are one of the key components of well being."

    find('button.featured-image').click

    expect(page).to have_css('#featuredModal', visible: true)
    expect(page).to have_css 'h4#featuredModalLabel', text: 'Featured Image'

    expect(page).to have_css 'h4', text: 'Featured Image'
    expect(page).to have_css '.alert', text: 'Select the image you would like to use.'
    expect(page).to have_css '.featured-image-picker'

    find("img[alt='#{my_image.name}']").click

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')

    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{my_image.file.featured}\"]") }

    click_button 'Save'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: 'Mindset Tweaks To Enhance Your Time In The Saddle')
    expect(page).to have_field('Slug', with: 'mindset-tweaks-to-enhance-your-time-in-the-saddle')
    expect(page).to have_css '.post_body div', text: 'Positive feelings are one of the key components of well being. Having fun and enjoying oneself, in addition to feeling good, has also been associated with improved health, personal efficiency, and productivity, and a bunch of other good things like hopefulness and creativity. Plus, when you’re happily enjoying yourself, it makes it easier for other people to feel good.'
    expect(page).to have_field('Excerpt', with: 'Positive feelings are one of the key components of well being.')
    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{my_image.file.featured}\"]") }

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'
  end

  scenario 'successfully edits a post with a featured image' do
    admin = create(:user, :admin)
    my_image = create(:image)
    replacement_image = create(:image_two)
    my_post = create(:post, featured_image: my_image.file.featured)

    login admin
    visit '/o_cms/posts'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: my_post.title)

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')

    expect(page).to within(:css, '#featured_preview') { have_xpath(".//img[@src=\"#{my_image.file.featured}\"]") }

    fill_in 'Title', with: "Adventure Cycling what to pack"
    find(".post_body").set("You have spent months dreaming and planning your bike journey. You have poured over maps and shopped for gear. You have been training hard and saving up. There is a frantic joy/dread to those final hours before you set out on a journey. Life never seems so hectic as those last couple of days before a big bike trip. What did you forget? Is that bike box overweight? Are you bringing too much stuff?")
    fill_in 'Excerpt', with: "Packing advice for the first time traveler. Life never seems so hectic as those last couple of days before a big bike trip."

    find('button.featured-image').click

    expect(page).to have_css('#featuredModal', visible: true)
    expect(page).to have_css 'h4#featuredModalLabel', text: 'Featured Image'

    expect(page).to have_css 'h4', text: 'Featured Image'
    expect(page).to have_css '.alert', text: 'Select the image you would like to use.'
    expect(page).to have_css '.featured-image-picker'

    find("img[alt='#{replacement_image.name}']").click

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')

    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{replacement_image.file.featured}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_field('Title', with: 'Adventure Cycling what to pack')
    expect(page).to have_css '.post_body div', text: 'You have spent months dreaming and planning your bike journey. You have poured over maps and shopped for gear. You have been training hard and saving up. There is a frantic joy/dread to those final hours before you set out on a journey. Life never seems so hectic as those last couple of days before a big bike trip. What did you forget? Is that bike box overweight? Are you bringing too much stuff?'
    expect(page).to have_field('Excerpt', with: 'Packing advice for the first time traveler. Life never seems so hectic as those last couple of days before a big bike trip.')
    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{replacement_image.file.featured}\"]") }

    visit '/o_cms/posts'

    expect(page).to have_content 'Adventure Cycling what to pack'
  end
end
