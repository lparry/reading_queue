puts "starting app"

require 'rubygems'
require 'bundler'
require 'logger'

Bundler.require

require 'sinatra'

require 'haml'
require 'active_record'

Dir.glob('models/*').each { |lib| require lib }

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
  haml :index
end

get '/*' do |page_template|
  begin
    haml page_template.to_sym
  rescue Errno::ENOENT
    halt 404, '404 Not Found!'
  end
end

