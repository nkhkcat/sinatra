# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'json'

before do
  file = File.read('data.json')
  @data = JSON.parse(file)
end

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
    'title' => "#{escape_text(params[:title])}",
    'content' => "#{escape_text(params[:content])}"
  }
  data['memos'].push(new_memo)

  write_json(data)

  redirect '/memos'
end

get '/memos/create' do
  erb :create
end

get '/memos/:id' do
  @id = id = params[:id]

  if @data['memos'].any? { |memo| memo['id'] == id }
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
  edited_memo = { 'title' => "#{escape_text(params[:title])}", 'content' => "#{escape_text(params[:content])}" }
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
  @id = params[:id]

  erb :edit
end

not_found do
  status 404
  erb :not_found
end
