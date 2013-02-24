FactoryGirl.define do
  factory :user do
    email "lawson@foobar.com"
    password "correct horse battery staple"
    password_confirmation "correct horse battery staple"
    avatar { fixture_file_upload(Rails.root.join('spec','fixtures','images','example.png'), 'image/png') }
  end
end