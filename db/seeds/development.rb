# frozen_string_literal: true

require 'faker'

puts 'Seeding development database...'
class BlogFiller
  dean = User.first_or_create!(email: 'dean@example.com',
                               password: 'password',
                               password_confirmation: 'password',
                               first_name: 'Dean',
                               last_name: 'DeHart',
                               role: User.roles[:admin])

  category = Category.first_or_create!(name: 'Uncategorized', display_in_nav: true)

  posts = []
  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: dean,
                    approve: false,
                    comments_count: 5,
                    category: category)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: dean)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)

  def create_users
    password = Faker::Internet.password(min_length: 6)
    20.times do
      User.create({
                    first_name: Faker::Name.name,
                    last_name: Faker::Name.last_name,
                    email: Faker::Internet.unique.email,
                    password: password,
                    password_confirmation: password
                  })
    end
  end

  def create_posts
    user_start = User.last.id - 20
    50.times do
      Post.create({
                    title: Faker::Movie.title,
                    body: Faker::Movie.quote,
                    user_id: Faker::Number.within(range: user_start..(user_start + 20)),
                    views: Faker::Number.within(range: 0..1000),
                    approve: Faker::Boolean.boolean,
                    category_id: Category.first.id
                  })
    end
  end

  def create_comments
    user_start = User.last.id - 20
    post_start = Post.last.id - 50
    100.times do
      user = User.find_by(id: Faker::Number.within(range: user_start..(user_start + 20)))
      next unless user

      Comment.create({
                       body: Faker::Movie.quote,
                       post_id: Faker::Number.within(range: post_start..(post_start + 50)),
                       user_id: user.id
                     })
    end
  end
end

blog_filler = BlogFiller.new

blog_filler.create_users
blog_filler.create_posts
blog_filler.create_comments
