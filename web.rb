require 'sinatra'
require 'json'
require_relative './disassembler'
require_relative './cache_manager'

post '/?' do
  cm = nil
  begin
    cm = CacheManager.new(logger, nil)
  rescue => e
    logger.error 'Error trying to connect to redis'
    logger.error e
  end

  begin
    json = JSON.parse request.body.read
    @diss = Disassembler.disassemble json['code'], cm
  rescue => e
    logger.error 'Error encountered while trying to dissassemble code'
    logger.error e
    @diss = e.message
  end
  erb :diss, :layout => false
end
