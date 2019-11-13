FactoryBot.define do
  factory :comment do
    
  end

  factory :user do
    email { 'person@person.com' }
    username { 'person' }
    password { 'password' }
  end

  factory :post do
    message { "Hello, world!" }
    user_id { User.all.first.id }
  end

  # factory :comment do
  #   id { 1 }
  #   post_id { 1 }
  # end

# end
end
