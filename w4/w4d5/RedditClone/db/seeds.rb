User.create!(name: "Carl", password: "carlcarl")
User.create!(name: "Kelly", password: "kellykelly")

Sub.create!(title: "Cats", description: "Developers seem to be obsessed with them.", moderator_id: 1)
Sub.create!(title: "Chickens", description: "They purr. Yeah.", moderator_id: 2)

PostSub.create!(post_id: 1, sub_id:1)
PostSub.create!(post_id: 2, sub_id:1)
PostSub.create!(post_id: 3, sub_id:1)
PostSub.create!(post_id: 3, sub_id:2)

Post.create!(title: "Cats are awesome.", content: "We really really like them in 2015.", author_id: 2)
Post.create!(title: "Cats are sooper cool.", content: "We still really really like them in 2016.", author_id: 2)
Post.create!(title: "Never met a chicken.", content: "But I really want to, I hear they purr.", author_id: 1)
