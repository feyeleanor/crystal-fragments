require "http/server"
require "json"
require "xml"

HOST = "localhost"
PORT = 1234

def serve(host, port, f : Proc(HTTP::Request, String), content_type = "application/json")
	server = HTTP::Server.new host, port do |context|
		puts "request to #{host}:#{port}"
		context.response.content_type = content_type
		context.response.output.print f.call context.request
	end
	Process.fork do
		server.listen
	end
end

def read_from(host, port)
	HTTP::Client.get("http://#{host}:#{port}/") do |response|
		case b = response.body_io.gets_to_end
		when String
			case response.content_type
			when /xml/
				if root = XML.parse(b).first_element_child
					root.children.select(&.element?).each do |child|
						yield child.content
					end
				end
			when /json/
				JSON.parse(b).each do |v|
					yield v
				end
			end
		end
	end
end

def print_from(host, port)
	i = 0
	read_from(host, port) do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end