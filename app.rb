# frozen_string_literal: true

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
set :haml, { format: :html5 } # default Haml format is :xhtml

#require 'pry'
#binding.pry
FillerText.style = FillerText::Style::YinzerIpsum
VALID_CHUNKS = %i[sentences words characters bytes paragraphs].freeze

# Application routes
get '/' do
  haml :index, layout: :'layouts/application'
end

get '/yinzer' do
  content_type 'text/plain'
  what = params[:chunk] || VALID_CHUNKS.first
  num = params[:num] || 1
  what = what.to_sym
  num = num.to_i
  raise 'Invalid chunk specified' unless VALID_CHUNKS.member?(what)

  FillerText.send what, num
end

get '/api' do
  haml :api, layout: :'layouts/page'
end

get '/health' do
  true
end
