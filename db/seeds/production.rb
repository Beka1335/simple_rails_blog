puts 'Seeding production database...'
beka = User.first_or_create!(email: 'barishvili@unisens.ge',
                             password: 'password',
                             password_confirmation: 'password',
                             first_name: 'Beka',
                             last_name: 'Arishvili',
                             role: User.roles[:admin])

john = User.first_or_create!(email: 'john@doe.com',
                             password: 'password',
                             password_confirmation: 'password',
                             first_name: 'John',
                             last_name: 'Doe')
category = Category.first_or_create!(name:"Uncategorized", display_in_nav: true)

elapsed = Benchmark.measure do
  posts = []
  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: beka,
                    approve: false,
                    comments_count: 5,
                    category: category)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: john)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts "Seeded development DB in #{elapsed.real} seconds"