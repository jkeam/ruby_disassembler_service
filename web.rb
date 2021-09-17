require 'sinatra'
require 'json'
require 'logger'
require_relative './disassembler'
require_relative './cache_manager'

configure :development do
  set :logging, Logger::DEBUG
end

cm = nil
configure do
  begin
    cm = CacheManager.new(ENV['REDIS_URL'])
  rescue => e
    # logger.error 'Error trying to connect to redis'
    # logger.error e
  end
end

post '/?' do
  begin
    cm.logger = logger if cm.logger.nil?
    json = JSON.parse request.body.read
    @diss = Disassembler.disassemble logger, json['code'], cm
  rescue => e
    logger.error 'Error encountered while trying to dissassemble code'
    logger.error e
    @diss = e.message
  end
  erb :diss, :layout => false
end
