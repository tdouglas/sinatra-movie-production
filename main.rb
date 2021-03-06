 require 'rubygems'
 require 'pry'
 require 'sinatra'
 require 'sinatra/reloader' if development?
 require 'pg'

helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

#root
get '/' do
  erb :index
end

#list all people
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

# displays input form to add new people
get '/people/new' do
  erb :new_person
end

# posts form info to database
post '/people/new' do
  name = params[:name]
  sql = "INSERT INTO people (name) VALUES ('#{name}')"
  run_sql(sql)
  redirect to('/people')
end

#list all movies
get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

# displays input form to add new movie
get '/movie/new' do
  erb :new_movie
end

# posts form info to database
post '/movie/new' do
  name = params[:name]
  date = params[:date]
  director = params[:director]
  sql = "INSERT INTO movie (name, release_date, director) VALUES ('#{name}', #{date}, '#{director}')"
  run_sql(sql)
  redirect to('/people')
end

# lists all tasks
get '/todos' do
  sql = "SELECT * FROM tasks"
  @todos = run_sql(sql)
  erb :todos
end

# displays input form to add new task
get '/todo/new' do
  erb :new_todo
end

# posts form info to database
post '/todo/new' do
  name = params[:name]
  description = params[:description]
  movie_id = params[:movie_id]
  person_id = params[:person_id]
  sql = "INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('#{name}', '#{description}', #{movie_id}, #{person_id})"
  run_sql(sql)
  redirect to('/todos')
end



