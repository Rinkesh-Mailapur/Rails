  # This file should ensure the existence of records required to run the application in every environment (production,
  # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
  # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
  #
  # Example:
  #
  #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
  #     MovieGenre.find_or_create_by!(name: genre_name)
  #   end
  # Clear existing data

  ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")
  # Clear existing data to avoid duplicates
  User.delete_all
  Post.delete_all
  Comment.delete_all
  Like.delete_all
  Category.delete_all
  Follow.delete_all

  # Create Categories first
  categories = [
    "Technology", "Health", "Travel", "Lifestyle", "Education", "Food", "Sports", "Entertainment", "Fashion", "Finance"
  ]

  categories.each do |cat_name|
    Category.find_or_create_by!(cat_name: cat_name)
  end

  users = [
  { name: 'Rinkesh', email: 'rinkesh@example.com', password: 'Password@123', mobile_number: '9876543210', gender: 'Male', birth_date: '1995-05-10' },
  { name: 'Sahil', email: 'sahil@example.com', password: 'Password@123', mobile_number: '9876543211', gender: 'Male', birth_date: '1996-02-20' },
  { name: 'Sudhansh', email: 'sudhansh@example.com', password: 'Password@123', mobile_number: '9876543212', gender: 'Male', birth_date: '1994-08-12' },
  { name: 'Anil', email: 'anil@example.com', password: 'Password@123', mobile_number: '9876543213', gender: 'Male', birth_date: '1993-11-15' },
  { name: 'Shivpal', email: 'shivpal@example.com', password: 'Password@123', mobile_number: '9876543214', gender: 'Male', birth_date: '1997-06-22' },
  { name: 'Animesh', email: 'animesh@example.com', password: 'Password@123', mobile_number: '9876543215', gender: 'Male', birth_date: '1995-01-01' }
]

users.each do |user_data|
  User.create!(user_data)  # Create users and let Rails handle password_digest
end


  # Ensure Users and Categories exist before creating Posts
  posts = [
    { title: "How to build a web app", content: "In this post, we'll explore how to build a simple web app using Ruby on Rails.", user: User.find_by(email: "rinkesh@example.com"), category: Category.find_by(cat_name: "Technology") },
    { title: "Health benefits of daily exercise", content: "Regular exercise is important for maintaining a healthy body and mind. Here’s a guide on how to get started.", user: User.find_by(email: "sahil@example.com"), category: Category.find_by(cat_name: "Health") },
    { title: "Top 10 travel destinations in 2025", content: "Planning your next adventure? Check out these amazing travel destinations for the year 2025.", user: User.find_by(email: "sudhansh@example.com"), category: Category.find_by(cat_name: "Travel") },
    { title: "How to manage stress effectively", content: "Stress management is key to living a healthy life. Here are some strategies to reduce stress.", user: User.find_by(email: "anil@example.com"), category: Category.find_by(cat_name: "Health") },
    { title: "Best food to stay fit and healthy", content: "Eating a balanced diet is essential for maintaining health. This post covers the best food for fitness.", user: User.find_by(email: "shivpal@example.com"), category: Category.find_by(cat_name: "Food") },
    { title: "Exploring the world of cryptocurrencies", content: "Cryptocurrencies are revolutionizing the financial world. In this post, we explore the basics of crypto.", user: User.find_by(email: "animesh@example.com"), category: Category.find_by(cat_name: "Finance") },
    { title: "Best practices for remote work", content: "Remote work has become more popular than ever. This post shares tips on how to work efficiently from home.", user: User.find_by(email: "sahil@example.com"), category: Category.find_by(cat_name: "Lifestyle") },
    { title: "Top 5 fashion trends in 2025", content: "Stay ahead of the curve with these 5 fashion trends that are set to dominate the year.", user: User.find_by(email: "anil@example.com"), category: Category.find_by(cat_name: "Fashion") }
  ]

  posts.each do |post_data|
    post = Post.new(post_data)
    post.save!
  end

  # Ensure Posts exist before creating Comments
  comments = [
    { message: "Great post! I’m excited to learn more about web development.", post: Post.find_by(title: "How to build a web app"), user: User.find_by(email: "sahil@example.com") },
    { message: "Exercise is key to staying healthy. Thanks for sharing these tips!", post: Post.find_by(title: "Health benefits of daily exercise"), user: User.find_by(email: "rinkesh@example.com") },
    { message: "I can't wait to visit these places next year!", post: Post.find_by(title: "Top 10 travel destinations in 2025"), user: User.find_by(email: "anil@example.com") },
    { message: "Stress management is so important! Thanks for the tips.", post: Post.find_by(title: "How to manage stress effectively"), user: User.find_by(email: "shivpal@example.com") },
    { message: "Healthy eating is the key to staying fit. Great suggestions!", post: Post.find_by(title: "Best food to stay fit and healthy"), user: User.find_by(email: "animesh@example.com") },
    { message: "I'm so excited about cryptocurrencies! Looking forward to reading more.", post: Post.find_by(title: "Exploring the world of cryptocurrencies"), user: User.find_by(email: "sahil@example.com") },
    { message: "I love working remotely! Thanks for the tips on staying productive.", post: Post.find_by(title: "Best practices for remote work"), user: User.find_by(email: "anil@example.com") },
    { message: "Fashion trends are always evolving! Excited to see what’s next.", post: Post.find_by(title: "Top 5 fashion trends in 2025"), user: User.find_by(email: "rinkesh@example.com") }
  ]

  comments.each do |comment_data|
    Comment.find_or_create_by!(comment_data)
  end

  # Ensure Comments exist before creating Likes
  like_posts = [
    { user: User.find_by(email: "rinkesh@example.com"), likeable: Post.find_by(title: "How to build a web app") },
    { user: User.find_by(email: "sahil@example.com"), likeable: Post.find_by(title: "Health benefits of daily exercise") },
    { user: User.find_by(email: "sudhansh@example.com"), likeable: Post.find_by(title: "Top 10 travel destinations in 2025") },
    { user: User.find_by(email: "anil@example.com"), likeable: Post.find_by(title: "How to manage stress effectively") },
    { user: User.find_by(email: "shivpal@example.com"), likeable: Post.find_by(title: "Best food to stay fit and healthy") },
    { user: User.find_by(email: "animesh@example.com"), likeable: Post.find_by(title: "Exploring the world of cryptocurrencies") },
    { user: User.find_by(email: "sahil@example.com"), likeable: Post.find_by(title: "Best practices for remote work") },
    { user: User.find_by(email: "anil@example.com"), likeable: Post.find_by(title: "Top 5 fashion trends in 2025") }
  ]

  like_posts.each do |like_data|
    Like.find_or_create_by!(like_data)
  end

  like_comments = [
    { user: User.find_by(email: "sahil@example.com"), likeable: Comment.find_by(message: "Great post! I’m excited to learn more about web development.") },
    { user: User.find_by(email: "rinkesh@example.com"), likeable: Comment.find_by(message: "Exercise is key to staying healthy. Thanks for sharing these tips!") },
    { user: User.find_by(email: "anil@example.com"), likeable: Comment.find_by(message: "I can't wait to visit these places next year!") },
    { user: User.find_by(email: "shivpal@example.com"), likeable: Comment.find_by(message: "Stress management is so important! Thanks for the tips.") },
    { user: User.find_by(email: "animesh@example.com"), likeable: Comment.find_by(message: "Healthy eating is the key to staying fit. Great suggestions!") },
    { user: User.find_by(email: "sahil@example.com"), likeable: Comment.find_by(message: "I'm so excited about cryptocurrencies! Looking forward to reading more.") },
    { user: User.find_by(email: "anil@example.com"), likeable: Comment.find_by(message: "I love working remotely! Thanks for the tips on staying productive.") },
    { user: User.find_by(email: "rinkesh@example.com"), likeable: Comment.find_by(message: "Fashion trends are always evolving! Excited to see what’s next.") }
  ]

  like_comments.each do |like_data|
    Like.find_or_create_by!(like_data)
  end
