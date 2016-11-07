require 'rails_helper'

RSpec.feature "Admin adds gallery to body field,", type: :feature, js: true do
  scenario 'browses library modal for gallery' do
    admin = create(:user, :admin)
    post = create(:post)
    gallery = create(:gallery_with_images)
    image = gallery.images.first
    second_image = gallery.images.second

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

    find('.gallery-nav-link').click

    expect(page).to have_css 'a.active', text: 'Galleries'
    expect(page).to have_css '.alert', text: 'Select the gallery you would like to add.'
    expect(page).to have_css '.gallery-picker'

    click_link gallery.name

    expect(page).to have_css 'h3', text: 'Add your gallery'
    expect(page).to have_css 'h4', text: gallery.name
    expect(page).to have_button('Insert')

    click_link 'Galleries'

    expect(page).to have_css 'a.active', text: 'Galleries'
    expect(page).to have_css '.alert', text: 'Select the gallery you would like to add.'
    expect(page).to have_css '.gallery-picker'
  end

  scenario 'inserts gallery' do
    admin = create(:user, :admin)
    post = create(:post)
    gallery = create(:gallery_with_images)
    image = gallery.images.first
    second_image = gallery.images.second

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

    find('.gallery-nav-link').click

    expect(page).to have_css 'a.active', text: 'Galleries'
    expect(page).to have_css '.alert', text: 'Select the gallery you would like to add.'
    expect(page).to have_css '.gallery-picker'

    click_link gallery.name

    expect(page).to have_css 'h3', text: 'Add your gallery'
    expect(page).to have_css 'h4', text: gallery.name
    expect(page).to have_button('Insert')

    click_button 'Insert'

    expect(page).to have_css('#libraryModal', visible: false)
    expect(page).to have_css('h4#libraryModalLabel', visible: false, text: 'Library')
    expect(page).to within(:css, '.post_body div') { have_css('.gallery-' + gallery.id.to_s) }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{second_image.file.thumb}\"]") }

    click_button 'Save'

    expect(page).to have_css '.alert', text: 'Post was updated successfully.'
    expect(page).to have_css 'h2', text: 'Edit Post'
    expect(page).to have_field('Title', with: post.title)
    expect(page).to have_css '.post_body div', text: post.body
    expect(page).to within(:css, '.post_body div') { have_css('.gallery-' + gallery.id.to_s) }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{image.file.thumb}\"]") }
    expect(page).to within(:css, '.post_body div') { have_xpath(".//img[@src=\"#{second_image.file.thumb}\"]") }
  end
end
