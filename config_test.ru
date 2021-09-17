$stdout.sync = true
require 'sinatra'
require './web_nocache'
run Sinatra::Application
