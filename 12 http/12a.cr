require "http/server"
require "json"

HOST = "localhost"
PORT = 8080

def serve(host, port, f : Proc(HTTP::Request, String))
	server = HTTP::Server.new host, port do |context|
		puts "request to #{host}:#{port}"
		context.response.content_type = "application/json"
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
			JSON.parse(b).each do |v|
				yield v
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

children = [] of Process
begin
	a = [0, 2, 4, 6, 8]
	children = [
		serve(HOST, PORT, ->(c : HTTP::Request) { a.to_json }),
		serve(HOST, PORT + 1, ->(c : HTTP::Request) { a.reverse.to_json })
	]
	sleep 1
	print_from HOST, PORT
	print_from HOST, PORT + 1
ensure
	children.each &.kill
end