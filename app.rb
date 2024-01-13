# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'json'

get '/memos' do
  file = File.read('data.json')
  @data = JSON.parse(file)

  erb :memos
end

post '/memos' do
  file = File.read('data.json')
  data = JSON.parse(file)

  new_memo = {
    'id' => (data['memos'].map { |memo| memo['id'].to_i }.max + 1).to_s,
    'title' => params[:title],
    'content' => params[:content]
  }

  data['memos'].push(new_memo)
  File.open('data.json', 'w') do |f|
    f.write(JSON.pretty_generate(data))
  end

  redirect '/memos'
end

get '/memos/create' do
  erb :create
end

get '/memos/:id' do
  file = File.read('data.json')
  @data = JSON.parse(file)
  @id = id = params[:id]

  if @data['memos'].any? { |memo| memo['id'] == id }
    erb :detail
  else
    status 404
    erb :not_found
  end
end

patch '/memos/:id' do
  file = File.read('data.json')
  data = JSON.parse(file)

  id = params[:id]
  memo = data['memos'].find { |m| m['id'] == id }
  edited_memo = { 'title' => params[:title], 'content' => params[:content] }
  memo.merge!(edited_memo)

  File.open('data.json', 'w') do |f|
    f.write(JSON.pretty_generate(data))
  end

  redirect '/memos'
end

get '/memos/:id/edit' do
  file = File.read('data.json')
  @data = JSON.parse(file)
  @id = params[:id]

  erb :edit
end

not_found do
  status 404
  erb :not_found
end
