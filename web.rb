require 'sinatra'
require 'json'
require_relative './disassembler'

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options '*' do
  response.headers['Allow'] = 'POST, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  response.headers['Access-Control-Allow-Origin'] = '*'
  200
end

post '/?' do
  begin
    json = JSON.parse request.body.read
    @diss = Disassembler.disassemble json['code']
  rescue => e
    logger.error "Error encountered while trying to dissassemble code"
    logger.error e
    @diss = e.message
  end
  erb :diss, :layout => false
end
