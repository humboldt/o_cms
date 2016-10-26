require 'rails_helper'

RSpec.feature "Admin adds image to body field", type: :feature, js: true do
  scenario 'successfully opens and closes library modal using the trix toolbar library button' do
    admin = create(:user, :admin)
    my_post = create(:post)

    login admin
    visit '/o_cms/posts'
    click_link 'Edit'

    expect(page).to have_css 'h1', text: 'Blog'
    expect(page).to have_css 'h2', text: 'Edit Post'

    expect(page).to_not have_css 'h4', text: 'Library'

    click_button('library')

    expect(page).to have_css 'h4', text: 'Library'

    click_button('close')

    expect(page).to_not have_css 'h4', text: 'Library'
  end
end
