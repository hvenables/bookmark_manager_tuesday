FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password  "secret1234"
    password_confirmation "secret1234"
  end

  factory :baduser, class: User do
    password  "secret12345"
    password_confirmation "secret"
  end

  factory :emptyuser, class: User do
    email ""
  end
end
