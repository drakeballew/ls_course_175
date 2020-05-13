require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.entries("public/").select { |f| !File.directory? f }.sort
  @reverse = params['reverse']
  if @reverse
    @files = @files.sort.reverse
  end

  erb :home
end


