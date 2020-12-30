require 'sinatra'
require 'json'
require_relative './disassembler'

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
