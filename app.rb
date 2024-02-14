# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'json'

helpers do
  def read_json
    file = File.read('data.json')
    JSON.parse(file)
  end

  def write_json(data)
    File.open('data.json', 'w') do |f|
      f.write(JSON.pretty_generate(data))
    end
  end

  def escape_text(text)
    Rack::Utils.escape_html(text)
  end
end

get '/memos' do
  erb :memos
end

post '/memos' do
  data = read_json

  new_memo = {
    'id' => (data['memos'].map { |memo| memo['id'].to_i }.max + 1).to_s,
    'title' => escape_text(params[:title]),
    'content' => escape_text(params[:content])
  }
  data['memos'].push(new_memo)

  write_json(data)

  redirect '/memos'
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @memo = read_json['memos'].find { |memo| memo['id'] == params[:id] }

if @memo
    erb :detail
  else
    status 404
    erb :not_found
  end
end

patch '/memos/:id' do
  data = read_json

  id = params[:id]
  memo = data['memos'].find { |m| m['id'] == id }
  edited_memo = { 'title' => escape_text(params[:title]), 'content' => escape_text(params[:content]) }
  memo.merge!(edited_memo)

  write_json(data)

  redirect '/memos'
end

delete '/memos/:id' do
  data = read_json

  id = params[:id]
  data['memos'].reject! { |memo| memo['id'] == id }

  write_json(data)

  redirect '/memos'
end

get '/memos/:id/edit' do
  @memo = read_json['memos'].find { |memo| memo['id'] == params[:id] }
  erb :edit
end

not_found do
  status 404
  erb :not_found
end
