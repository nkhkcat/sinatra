# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/memos' do
  file = File.read('data.json')
  @data = JSON.parse(file)
  erb :memos
end

post '/memos' do
  # TODO： 新規作成処理
end

get '/memos/create' do
  erb :create
end

get '/memos/:id' do
  @id = params[:id]

  erb :detail
end

patch '/memos/:id' do
  # TODO: 更新処理
end

get '/memos/:id/edit' do
  erb :edit
end

not_found do
  status 404
  erb :not_found
end
