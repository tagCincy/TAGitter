@users = FactoryGirl.create_list(:confirmed_user, 25)
             .tap { |users| users.concat(FactoryGirl.create_list(:protected_user, 5)) }

@users.each { |user| FactoryGirl.create_list(:post, rand(1..15), user: user) }
