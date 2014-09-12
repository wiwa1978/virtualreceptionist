require 'sinatra/base'

module Sinatra
  module ResponseFormat
    def format_response(data, accept)
      accept.each do |type|
        return data.to_xml  if type.downcase.eql? 'text/xml'
        return data.to_json if type.downcase.eql? 'application/json'
        return data.to_yaml if type.downcase.eql? 'text/x-yaml'
        return data.to_csv  if type.downcase.eql? 'text/csv'
        return data.to_json
      end
    end

   
  end
  helpers ResponseFormat
end

require 'do_postgres'
require 'dm-do-adapter'

module DataMapper
  module Adapters
 
    class PostgresAdapter < DataObjectsAdapter
 
      module SQL #:nodoc:
        private
 
        # @api private
        def supports_returning?
          true
        end
 
        def like_operator(operand)
          'ILIKE'
        end
      end
 
      include SQL
 
    end
 
    const_added(:PostgresAdapter)
 
  end
end
