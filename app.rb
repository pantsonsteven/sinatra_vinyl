require 'bundler'
require 'sinatra/activerecord'
Bundler.require

db = URI.parse('postgres://stevendoran@localhost/vinyl')

ActiveRecord::Base.establish_connection(
   adapter:    db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   host:       db.host,
   username:   db.user,
   password:   db.password,
   database:   db.path[1..-1],
   encoding:   'utf8'
   )

class Record < ActiveRecord::Base
end

# INDEX
get '/' do 
   redirect '/records'
end

get '/records' do 
   @records = Record.order('created_at DESC')
   redirect '/records/new' if @records.empty?

   erb :index
end

# NEW
get '/records/new' do 
   erb :new
end

# SHOW
get '/records/:id' do 
   @record = Record.find(params[:id])
   erb :show
end

#CREATE
post '/records' do 
   @record = Record.new(artist: params[:artist], title: params[:title])

   if @record.save
      redirect "/records"
   else
      erb :new
   end

end

#EDIT
get '/records/:id/edit' do 
   @record = Record.find(params[:id])

   erb :edit
end

#UPDATE
put '/records/:id' do 
   record = Record.find(params[:id])
   record.update(artist: params[:artist], title: params[:title])

   redirect "records/#{record.id}"
end


#DESTROY
delete '/records/:id' do
   Record.delete(params[:id])   
   
   redirect '/records'
end