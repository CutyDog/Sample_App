User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

User.create!(name: "Taishi", email: "taishi@email.com",
              password: "taishi", password_confirmation: "taishi",
              activated: true, activated_at: Time.zone.now)

User.create!(name: "Momoka", email: "momoka@email.com",
              password: "momoka", password_confirmation: "momoka",
              activated: true, activated_at: Time.zone.now)

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

#トーク
members = users[2..30]
members.each do |member|
  talk = Talk.create!
  #メンバーシップ
  talk.memberships.create!(user: user)
  talk.memberships.create!(user: member)
  #メッセージ
  talk.messages.create!(user: user, content: Faker::Lorem.sentence(5))
  talk.messages.create!(user: member, content: Faker::Lorem.sentence(5))
end  