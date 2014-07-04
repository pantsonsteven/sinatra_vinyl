require 'bundler'
Bundler.require

# INDEX
get '/' do 
   redirect '/records'
end

get '/records' do 

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = 'SELECT * FROM records;'
   response = connection.exec(sql_statement)

   @records = response.map do |record|
      {'id' => record['id'], 'title' => record['title'], 'artist' => record['artist']}
   end

   connection.close

   erb :index

end

# SHOW
get '/records/:id' do 
   id = params[:id]

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = "SELECT * FROM records WHERE id=#{id}"
   response = connection.exec(sql_statement)

   @record = response.map do |record|
      {'id' => record['id'], 'title' => record['title'], 'artist' => record['artist']}      
   end

   connection.close

   erb :show
end

# NEW
get '/records/new' do 
   erb :new
end

#CREATE
post '/records' do 
   title = params[:title]
   artist = params[:artist]

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = "INSERT INTO records (title, artist) VALUES ('#{title}', '#{artist}');"
   response = connection.exec(sql_statement)

   connection.close

   redirect '/records'
end

#EDIT
get '/records/:id/edit' do 
   id = params[:id]

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = "SELECT * FROM records WHERE id=#{id}"
   response = connection.exec(sql_statement)

   @record = response.map do |record|
      {'id' => record['id'], 'title' => record['title'], 'artist' => record['artist']}      
   end 

   connection.close

   erb :edit
end

#UPDATE
put '/records/:id' do 
   id = params[:id]
   title = params[:title]
   artist = params[:artist]

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = "UPDATE records SET artist='#{artist}', title='#{title}' WHERE id=#{id};"
   response = connection.exec(sql_statement)

   connection.close

   redirect "records/#{id}"
end


#DESTROY
delete '/records/:id' do
   id = params[:id]

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = "DELETE FROM records WHERE id=#{id};"
   response = connection.exec(sql_statement)

   connection.close
      
   redirect '/'
end