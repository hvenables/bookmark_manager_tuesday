feature 'User sign up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  scenario 'I can sign up as a new user' do
    expect { sign_up(@user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, foo@bar.com')
    expect(User.first.email).to eq('foo@bar.com')
  end

  scenario 'requires a matching confirmation password' do
    user = FactoryGirl.build(:baduser)
    expect { sign_up(user) }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    user = FactoryGirl.build(:baduser)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'cannot sign up without a email address' do
    user = FactoryGirl.build(:emptyuser)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up(@user)
    expect { sign_up(@user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end
