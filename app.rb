require 'sinatra'
require 'json'

currentId = 4
now = Time.now
messages = [
    {id: 1, username: 'Mariov', text: 'Where are you Luigiov?', date:now},
    {id: 2, username: 'Luigiov', text: 'Me iz here!', date: now+1000},
    {id: 3, username: 'Mariov', text: 'OK!', date: now+5000}
]

get '/' do
  'Endpoint:<br>&nbsp;&nbsp;&nbsp;&nbsp;(GET) /Messages<br>&nbsp;&nbsp;&nbsp;&nbsp;(POST) /Message<br>&nbsp;&nbsp;&nbsp;&nbsp;(DELETE) /Message/:id<br><br>Message Structure:<br>{<br>  username: "Mariov",<br>  text: "Where are you Luigiov?"<br>}'
end

get '/messages' do
  content_type :json
  status 200
  messages.to_json
end

post '/message' do
  content_type :json

  message = params[:message]
  message[:id] = currentId
  currentId += 1
  messages << message
  
  status 201
end

delete '/message/:id' do
  id = params[:id]

  messages.map.with_index do |val, index|
    messages.delete_at index if val[:id].to_i == id.to_i
  end

  status 200
end
