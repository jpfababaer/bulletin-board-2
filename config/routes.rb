#1 Utilizing the Devise gem. This automates the process of getting all of the RCAVs for sign-in, sign-out, edit profile, delete profile, and delete user account. 

#2 In this project, Devise is already installed BUT if not, we can go to the terminal and use the command: rails generate devise:install.

#3 When we do rails generate devise:install, make sure to follow the initialzer steps it provides. Step 1 -> SEARCH config/environments/development.rb

Rails.application.routes.draw do
#10 This line of code generates the RCAVs involved with the user login, sign up, etc. Use /rails/info/routes to see all available routes. SEARCH app/views/layouts/application.html.erb 
  devise_for :users

#5 Instead of the ROOT URL below...
# get("/", { :controller => "boards", :action => "index" })

# ...we recreate this root URL by copy/pasting step 2 of the initialization in the terminal. Make sure the value inside of the String matches the .get() route we for the HOMEPAGE. SEARCH app/views/layouts/application.html
  root to: "boards#index" 

#8 RESETTING FLOW! Generate the Users table in the terminal using the command: rails generate devise user. This NEW devise generator automatically generates columns: email and password. Additional columns we might want would need to be specified in the rails command.

#9 Use rake db:migrate to create the User database table. RESTART WEB SERVER first after installing the Devise gem so that the initializer is loaded = Stop Webpage and bin/dev again. Look up!

  # Routes for the Post resource:

  # CREATE
  post("/insert_post", { :controller => "posts", :action => "create" })
          
  # READ
  get("/posts", { :controller => "posts", :action => "index" })
  
  get("/posts/:path_id", { :controller => "posts", :action => "show" })
  
  # UPDATE
  
  post("/modify_post/:path_id", { :controller => "posts", :action => "update" })
  
  # DELETE
  get("/delete_post/:path_id", { :controller => "posts", :action => "destroy" })

  #------------------------------

  # Routes for the Board resource:

  # CREATE
  post("/insert_board", { :controller => "boards", :action => "create" })
          
  # READ
  get("/boards", { :controller => "boards", :action => "index" })
  
  get("/boards/:path_id", { :controller => "boards", :action => "show" })
  
  # UPDATE
  
  post("/modify_board/:path_id", { :controller => "boards", :action => "update" })
  
  # DELETE
  get("/delete_board/:path_id", { :controller => "boards", :action => "destroy" })

  #------------------------------

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
