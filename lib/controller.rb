class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(Gossip.id_new, params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show_gossip, locals: {gossip: Gossip.find_one(params['id']), comments: Comment.find_many(params['id'])}
  end

  get '/gossips/:id/edit' do
    erb :update_gossip, locals: {gossip: Gossip.find_one(params['id'])}
  end

  post '/gossips/update/' do
    Gossip.new(params['gossip_id'].to_i, params['gossip_author'], params['gossip_content']).update
    redirect '/'
  end

  post '/gossips/:id' do
    Comment.new(Comment.id_new, params['gossip_id'].to_i, params['comment_author'], params['comment_content'], Time.now).save
    redirect '/'
  end

end
