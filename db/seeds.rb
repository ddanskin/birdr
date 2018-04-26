User.create(first_name: "Bob", last_name: "Tester", username: "testerBob", city: "New York", state: "NY", country: "USA", email: "test@email.com", password: "test123", about_blurb: "hi", over_12: "true")

Post.create(image: "none", text: "This is my first post!", tag_list: "first,hello", user_id: 1)

Tag.create(text: "first")
Tag.create(text: "hello")


Post_Tag.create(post_id: 1, tag_id: 1)
Post_Tag.create(post_id: 1, tag_id: 2)

