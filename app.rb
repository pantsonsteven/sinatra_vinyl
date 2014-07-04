require 'bundler'
Bundler.require

get '/' do 
   redirect '/records'
end

get '/records' do 

   connection = PG.connect(dbname: 'vinyl')
   sql_statement = 'SELECT * FROM records;'
   response = connection.exec(sql_statement)

   @records = response.map do |record|
      {'title' => record['title'], 'artist' => record['artist']}
   end

   connection.close

   erb :index

end