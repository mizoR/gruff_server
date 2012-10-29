require 'sinatra/base'
require 'gruff_server/core'
require 'gruff_server/helper'

module GruffServer

  def self.server(root, options={})
    params = {
      graphs_folder: Proc.new { File.join(public_folder, 'graphs') }
    }.merge(options)

    server_class = Class.new(Sinatra::Base) do
      set :root, root
      params.each_pair do |key, value|
        set key, value
      end

      include GruffServer::Core
      include GruffServer::Helper
    end

    @server ||= server_class.new
  end

end
