desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  puts "Sample data task running"
  if Rails.env.development?
  #18 More clean up. Destroy all the User Instances if the Rails environment is NOT in development. 
    User.destroy_all
    Board.destroy_all
    Post.destroy_all
  end

  if Rails.env.production?
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  #15 This houses the sample data thats been graciously created for us. Now we are going to create more users so that we can populate the user_id column of Posts and Boards. Run rake sample_data to reset the Databases.
  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save
  end
  
  
  5.times do
    board = Board.new
    board.name = Faker::Address.community
  #16 This randomly chooses one of the users and adds a foreign key value for the column user_id in the Boards database.
    board.user_id = User.all.sample.id
    board.save

    rand(10..50).times do
      post = Post.new
  #17 Same reasoning as Step #16. User.all.sample gives me one RANDOM User instance to play around with in the line below. 
      post.user_id = User.all.sample.id
      post.board_id = board.id
      post.title = rand < 0.5 ? Faker::Commerce.product_name : Faker::Job.title
      post.body = Faker::Lorem.paragraphs(number: rand(1..5), supplemental: true).join("\n\n")
      post.created_at = Faker::Date.backward(days: 120)
      post.expires_on = post.created_at + rand(3..90).days
      post.save
    end
  end

  puts "There are now #{User.count} rows in the boards table."
  puts "There are now #{Board.count} rows in the boards table."
  puts "There are now #{Post.count} rows in the posts table."
end
