require 'json'

module GruffServer
  module Core
    def self.included(base)
      base.post '/graphs' do
        begin
          params = JSON.parse(request.body.tap { |io| io.rewind }.read)

          gruff(params) do |g|
            g.write(saved_pathname(hashed_basename))
          end
        rescue JSON::ParserError => e
          content_type :json
          halt 400, JSON.unparse({result: :error, message: e.message})
        else
          graph_url = URI.parse(request.url).tap { |uri|
            uri.path = "/graphs/#{hashed_basename}.#{extension}"
          }.to_s
          content_type :json
          JSON.unparse({result: :success, graph_url: graph_url})
        end
      end

      base.get %r{^/graphs/([a-zA-Z0-9]+)\.(png|jpg|gif)$} do |hashed, ext|
        content_type ext
        send_file saved_pathname(hashed, ext)
      end
    end
  end
end
