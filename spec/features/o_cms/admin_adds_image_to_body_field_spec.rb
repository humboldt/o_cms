require 'rails_helper'

RSpec.feature "Admin adds image to body field,", type: :feature, js: true do
  scenario 'successfully opens and closes library modal using the trix toolbar and library modal close button' do
    admin = create(:user, :admin)
    post = create(:post)

    login admin
    visit '/o_cms/posts'
    click_link 'Edit'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Edit Post'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'

    find('.modal-header button.close').click

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
  end

  scenario 'browses library modal for image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'
    click_link 'Edit'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Edit Post'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")

    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    expect(page).to have_field('Alignment')
    within(:css, 'select#alignment') do

      # TODO: Include text and value in one line, apple to all of selection options below
      # expect(page).to have_xpath(".//option[text()=\"None\"]")

      expect(page).to have_xpath(".//option[@value=\"none\"]")
      expect(page).to have_xpath(".//option[@value=\"left\"]")
      expect(page).to have_xpath(".//option[@value=\"right\"]")
      expect(page).to have_xpath(".//option[@value=\"center\"]")
    end
    expect(page).to have_field('Size')
    within(:css, 'select#size') do
      expect(page).to have_xpath(".//option[@value=\"#{image.file.thumb}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.medium}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.large}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.featured}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.special}\"]")
    end
    expect(page).to have_field('Link To')
    within(:css, 'select#link_to') do
      expect(page).to have_xpath(".//option[@value=\"url\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.thumb}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.medium}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.large}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.featured}\"]")
      expect(page).to have_xpath(".//option[@value=\"#{image.file.special}\"]")
    end
    expect(page).to have_button('Insert')

    click_link 'Images'

    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'
  end

  scenario 'inserts image into post body content area' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Add Post'

    expect(page).to have_css 'h2', text: 'New Post'
    expect(page).to have_current_path '/o_cms/posts/new'
    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    fill_in 'Title', with: "Mindset Tweaks To Enhance Your Time In The Saddle"
    find(".post_body").set("Positive feelings are one of the key components of well being. Having fun and enjoying oneself, in addition to feeling good, has also been associated with improved health, personal efficiency, and productivity, and a bunch of other good things like hopefulness and creativity. Plus, when you’re happily enjoying yourself, it makes it easier for other people to feel good.")

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    expect(page).to have_field('Alignment')
    expect(page).to have_field('Size')
    expect(page).to have_field('Link To')
    expect(page).to have_button('Insert')

    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }

    fill_in 'Excerpt', with: "Positive feelings are one of the key components of well being."
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was saved successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: 'Mindset Tweaks To Enhance Your Time In The Saddle')
    expect(page).to have_field('Slug', with: 'mindset-tweaks-to-enhance-your-time-in-the-saddle')
    expect(page).to have_css '.post_body div', text: 'Positive feelings are one of the key components of well being. Having fun and enjoying oneself, in addition to feeling good, has also been associated with improved health, personal efficiency, and productivity, and a bunch of other good things like hopefulness and creativity. Plus, when you’re happily enjoying yourself, it makes it easier for other people to feel good.'
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to have_field('Excerpt', with: 'Positive feelings are one of the key components of well being.')
  end

  scenario 'inserts image with adjusted alternate text' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    fill_in 'Alt Text', with: 'My first morning in the mountains'
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }

    fill_in 'Excerpt', with: "Positive feelings are one of the key components of well being."
    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
  end

  scenario 'inserts left aligned image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Left', :from => 'Alignment')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0px 10px 10px 0px; float: left;\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0px 10px 10px 0px; float: left;\"]") }
  end

  scenario 'inserts right aligned image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Right', :from => 'Alignment')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"float: right; margin: 0px 0px 10px 10px;\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"float: right; margin: 0px 0px 10px 10px;\"]") }
  end

  scenario 'inserts centerally aligned image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Center', :from => 'Alignment')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0 auto; display: block;\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0 auto; display: block;\"]") }
  end

  scenario 'inserts thumb image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Thumb', :from => 'Size')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
  end

  scenario 'inserts medium image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Medium', :from => 'Size')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.medium}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.medium}\"]") }
  end

  scenario 'inserts large image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Large', :from => 'Size')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.large}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.large}\"]") }
  end

  scenario 'inserts featured image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Featured', :from => 'Size')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.featured}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.featured}\"]") }
  end

  scenario 'inserts special image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Special', :from => 'Size')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.special}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.special}\"]") }
  end

  scenario 'inserts image linking to a URL' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('URL', :from => 'Link To')

    expect(page).to have_css('.link_url', visible: true)

    fill_in 'URL', with: "https://my-adventure-picture-blog.co.uk"
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"https://my-adventure-picture-blog.co.uk\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"https://my-adventure-picture-blog.co.uk\"]") }
  end

  scenario 'inserts image linking to a thumb image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Thumb Image', :from => 'Link To')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.thumb}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.thumb}\"]") }
  end

  scenario 'inserts image linking to a medium image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Medium Image', :from => 'Link To')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.medium}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.medium}\"]") }
  end

  scenario 'inserts image linking to a large image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Large Image', :from => 'Link To')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.large}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.large}\"]") }
  end

  scenario 'inserts image linking to a featured image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Featured Image', :from => 'Link To')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.featured}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.featured}\"]") }
  end

  scenario 'inserts image linking to a special image' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    select('Special Image', :from => 'Link To')
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.special}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.special}\"]") }
  end

  scenario 'inserts a centerally aligned medium image linking to a url with new alt text' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    fill_in 'Alt Text', with: 'My first morning in the mountains'
    select('Center', :from => 'Alignment')
    select('Medium', :from => 'Size')
    select('URL', :from => 'Link To')

    expect(page).to have_css('.link_url', visible: true)

    fill_in 'URL', with: "https://my-adventure-picture-blog.co.uk"
    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.medium}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0 auto; display: block;\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"https://my-adventure-picture-blog.co.uk\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.medium}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0 auto; display: block;\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"https://my-adventure-picture-blog.co.uk\"]") }
  end

  scenario 'inserts a right aligned large image linking to a special image with new alt text' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    fill_in 'Alt Text', with: 'My first morning in the mountains'
    select('Right', :from => 'Alignment')
    select('Large', :from => 'Size')
    select('Special Image', :from => 'Link To')

    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.large}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"float: right; margin: 0px 0px 10px 10px;\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.special}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.large}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"float: right; margin: 0px 0px 10px 10px;\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.special}\"]") }
  end

  scenario 'inserts a centerally aligned medium image linking to a featured image with new alt text' do
    admin = create(:user, :admin)
    post = create(:post)
    image = create(:image)

    login admin
    visit '/o_cms/posts'

    click_link 'Edit'

    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_current_path (o_cms.edit_post_path(post))

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')

    find('.library').click

    expect(page).to have_css('#libraryModal', visible: true)
    expect(page).to have_css 'h4#libraryModalLabel', text: 'Library'
    expect(page).to have_css 'a.active', text: 'Images'
    expect(page).to have_css '.alert', text: 'Select the image you would like to add.'
    expect(page).to have_css '.image-picker'

    find("img[alt='#{image.name}']").click

    expect(page).to have_css 'h3', text: 'Add your image'
    expect(page).to have_css '.preview-frame img'
    expect(page).to have_xpath("//img[@src=\"#{image.file.admin_thumb}\"]")
    expect(page).to have_field('Alt Text', with: image.name.titlecase )

    fill_in 'Alt Text', with: 'My first morning in the mountains'
    select('Center', :from => 'Alignment')
    select('Medium', :from => 'Size')
    select('Featured Image', :from => 'Link To')

    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.medium}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0 auto; display: block;\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.featured}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.medium}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@alt=\"My first morning in the mountains\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@style=\"margin: 0 auto; display: block;\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//a[@href=\"#{image.file.featured}\"]") }
  end
end
