require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'
require 'pry-byebug'

before do
  @users = YAML.load(File.read("users.yaml"))
end

helpers do
  def count_users(users)
    users.keys.size
  end

  def count_interests(users)
    interests = []
    users.each do |user|
      interests << user[1][:interests]
    end
    binding.pry
    interests.flatten.uniq.size
  end

end

get "/" do
  redirect "/users"
end

get "/users" do
  @names = @users.keys

  erb :users
end

get "/users/:name" do
  user_name = params[:name].to_sym
  @email = @users[user_name][:email]
  @interests = @users[user_name][:interests]

  @other_users = @users.keys - [user_name]


  erb :user
end


