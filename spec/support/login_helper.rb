module LoginHelper
  def login(user)
    visit '/users/sign_in'
    expect(page).to have_css 'h1', text: 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_current_path '/o_cms/'
    expect(page).to have_text 'Welcome to Outside CMS'
  end

  # def logout
  #   click_link 'sign out'
  #   expect(page).to have ...
  # end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :feature
end