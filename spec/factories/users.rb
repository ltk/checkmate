FactoryGirl.define do
  factory :user do
    email "lawson@foobar.com"
    password "correct horse battery staple"
    password_confirmation "correct horse battery staple"
  end
end