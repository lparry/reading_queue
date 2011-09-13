puts "starting app"

require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra'

require 'haml'
require 'active_record'

Dir.glob(File.expand_path('../models/*', __FILE__)).each { |lib| require lib }

dbconfig = YAML.load(File.read('config/database.yml'))
current_environment = ENV['RACK_ENV'] || 'development'
ActiveRecord::Base.establish_connection(dbconfig[current_environment])

use Rack::Auth::Basic do |username, password|
  # Yes, I know these are public. No, I dont care
  username == 'losername' && password == 'assword'
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  @item = QueueItem.unread.first
  if @item
    haml :index, :layout => false
  else
    haml :no_more_items
  end
end

get '/nav?' do
  @url = QueueItem.unread.first.try(:url)
  haml :nav, :layout => false
end

get '/mark_read?' do
  item = QueueItem.unread.first
  item.read = true
  item.save!
  redirect '/'
end

get '/delete' do
  if params[:id]
    QueueItem.find(params[:id].to_i).try(:destroy)
    redirect '/queue'
  end
end

get '/add' do
  if params[:url]
    QueueItem.create!(:url => params[:url])
    redirect '/queue'
  end
end

get '/queue' do
  @queue = QueueItem.all
  haml :queue
end

get '/*' do |page_template|
  begin
    haml page_template.to_sym
  rescue Errno::ENOENT
    halt 404, '404 Not Found!'
  end
end

