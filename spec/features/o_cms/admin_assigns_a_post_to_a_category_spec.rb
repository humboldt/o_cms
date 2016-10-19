require 'rails_helper'

RSpec.feature "Admin assigns a post to a category", type: :feature, js: true do
  scenario 'successfully creates a draft post' do
    admin = create(:user, :admin)
    my_post = create(:post)
    my_category = create(:category)

    login admin
    click_link 'Blog'

    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'

    click_link 'Categories'

    expect(page).to have_current_path '/o_cms/categories'
    expect(page).to have_css 'h1', text: 'Categories'
    expect(page).to have_css 'h2', text: 'Categories'
    expect(page).to have_content(my_category.name)

    click_link 'Posts'

    expect(page).to have_current_path '/o_cms/posts'
    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Posts'
    expect(page).to have_content(my_post.title)

    click_link 'Edit'
    check(my_category.name)
    click_button 'Save'

    expect(page.has_checked_field?('post_category_ids_#{my_category.id}'))
  end
end
