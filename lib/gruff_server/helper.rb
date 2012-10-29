require 'digest/md5'
require 'gruff'

module GruffServer
  module Helper
    def self.included(base)
      base.helpers do
        def hashed_basename
          return @hashed_basename if @hashed_basename

          key = %Q(#{Time.now.to_i}-#{(rand() * 100000000).to_i})
          @hashed_basename = Digest::MD5.hexdigest(key).to_s
        end

        def saved_pathname(basename, ext=extension)
           File.join(settings.graphs_folder, "#{basename}.#{ext}")
        end

        def extension
          return settings.extension if settings.respond_to?(:extension)
          'png'
        end

        def gruff(params, options={})
          g = Gruff::Line.new

          # Parse parameters
          data = params.delete('data')
          labels = params.delete('labels')

          # set parameters
          params.each_pair do |method, value|
            setter = method.to_s + '='
            g.send(setter, value) if g.respond_to?(setter)
          end

          # set data
          data.each_pair do |name, values|
            g.data(name, values)
          end

          # set labels
          g.labels = labels.inject({}) { |_labels, (key, value)|
            _labels[key.to_i] = value
            _labels
          } if labels

          yield(g)
        end
      end
    end
  end
end
