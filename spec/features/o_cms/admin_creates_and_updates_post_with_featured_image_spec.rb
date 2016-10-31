require 'rails_helper'

RSpec.feature "Admin manages featured image in a post,", type: :feature, js: true do
  scenario 'successfully opens and closes featured modal using the select image button and featured modal close button' do
    admin = create(:user, :admin)
    post = create(:post)

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
    image = create(:image)
    post = create(:post)

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

    fill_in 'Title', with: post.title
    find(".post_body").set(post.body)

    find('button.featured-image').click

    expect(page).to have_css('#featuredModal', visible: true)
    expect(page).to have_css 'h4#featuredModalLabel', text: 'Featured Image'
    expect(page).to have_css 'h4', text: 'Featured Image'
    expect(page).to have_css '.alert', text: 'Select the image you would like to use.'
    expect(page).to have_css '.featured-image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')
    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{image.file.featured}\"]") }

    click_button 'Save'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{image.file.featured}\"]") }

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'
  end

  scenario 'successfully edits a post with a featured image' do
    admin = create(:user, :admin)
    image = create(:image)
    post = create(:post, featured_image: image.file.featured)
    replacement_image = create(:forest_image)

    login admin
    visit '/o_cms/posts'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css('#featuredModal', visible: false)
    expect(page).to have_css('h4#featuredModalLabel', visible: false, text: 'Featured Image')
    expect(page).to within(:css, '#featured_preview') { have_xpath(".//img[@src=\"#{image.file.featured}\"]") }

    fill_in 'Title', with: "Adventure Cycling what to pack"
    find(".post_body").set("You have spent months dreaming and planning your bike journey. You have poured over maps and shopped for gear. You have been training hard and saving up. There is a frantic joy/dread to those final hours before you set out on a journey. Life never seems so hectic as those last couple of days before a big bike trip. What did you forget? Is that bike box overweight? Are you bringing too much stuff?")

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
    expect(page).to within(:css, '.featured-card') { have_xpath(".//img[@src=\"#{replacement_image.file.featured}\"]") }

    visit '/o_cms/posts'

    expect(page).to have_content 'Adventure Cycling what to pack'
  end
end
