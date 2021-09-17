require 'sinatra'
require 'json'
require 'logger'
require_relative './disassembler'
require_relative './cache_manager'

configure :development do
  set :logging, Logger::DEBUG
end

post '/?' do
  cm = nil
  begin
    json = JSON.parse request.body.read
    @diss = Disassembler.disassemble logger, json['code'], nil
  rescue => e
    logger.error 'Error encountered while trying to dissassemble code'
    logger.error e
    @diss = e.message
  end
  erb :diss, :layout => false
end
