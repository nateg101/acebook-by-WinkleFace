FactoryBot.define do
  factory :user do
    email { 'person@person.com' }
    username { 'person' }
    password { 'password' }
  end

  factory :post do
    message { "Hello, world!" }
    user_id { User.all.first.id }
  end

  factory :comment do
    message { 'A comment' }
    post_id { Post.all.first.id }
    user_id { User.all.first.id }
  end
end
