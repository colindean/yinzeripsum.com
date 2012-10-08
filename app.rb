require 'rubygems'
require 'sinatra'
require 'haml'
require 'fillertext'

# Helpers
require './lib/render_partial'

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public_folder, 'public'
set :haml, {:format => :html5} # default Haml format is :xhtml

FillerText::FillerText.style = FillerText::Style::YinzerIpsum
VALID_CHUNKS = [:sentences, :words, :characters, :bytes, :paragraphs]

# Application routes
get '/' do
  haml :index, :layout => :'layouts/application'
end

get '/yinzer' do
  content_type 'text/plain'
  what = params[:chunk] || VALID_CHUNKS.first
  num = params[:num] || 1
  what = what.to_sym
  num = num.to_i
  raise "Invalid chunk specified" if !VALID_CHUNKS.member?(what)

  FillerText::FillerText.send what, num
end

get '/api' do
  haml :api, :layout => :'layouts/page'
end
