require "./12b.include"
require "xml"

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

children = [] of Process
begin
	a = [0, 2, 4, 6, 8]
	children = [
		serve(HOST, PORT, ->(c : HTTP::Request) {
			a.to_json
		}),
		serve(HOST, PORT + 1, ->(c : HTTP::Request) {
			"<array type=\"#{typeof(a)}\">" +
			a.reverse.map_with_index { |v, i|
				"<element id=\"#{i}\">#{v}</element>"
			}.join +
			"</array>"
		}, "application/xml")
	]
	sleep 1
	print_from HOST, PORT
	print_from HOST, PORT + 1
ensure
	children.each &.kill
end