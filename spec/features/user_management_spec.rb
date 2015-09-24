feature 'User sign up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  scenario 'I can sign up as a new user' do
    user = FactoryGirl.create(:user)
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, foo@bar.com')
    expect(User.first.email).to eq('foo@bar.com')
  end

  scenario 'requires a matching confirmation password' do
    # again it's questionable whether we should be testing the model at this
    # level.  We are mixing integration tests with feature tests.
    # However, it's convenient for our purposes.
    user = FactoryGirl.create(:baduser)
    expect { sign_up(user) }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    user = FactoryGirl.create(:baduser)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'cannot sign up without a email address' do
    user = FactoryGirl.create(:emptyuser)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
  end

  def sign_up(user)
    visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end
end
