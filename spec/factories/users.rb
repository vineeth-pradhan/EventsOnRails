FactoryBot.define do
  factory :user do
    username "abc123"
    email "abc123@example.com"
    phone "999999123"
  end

  factory :user_with_no_username, class: User do
    username "abc123"
    phone "999999123"
  end

  factory :user_with_no_email, class: User do
    username "abc123"
    phone "999999123"
  end

  factory :user_with_no_phone, class: User do
    username "abc123"
    email "abc123@example.com"
  end
end
