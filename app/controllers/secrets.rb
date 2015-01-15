before '/secrets*' do
  session_authenticate!
end

get '/secrets' do
  erb :secrets
end