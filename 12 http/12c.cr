require "./12c.include"

class Array
	def to_xml
		"<array type=\"#{typeof(self)}\">" +
		self.map_with_index { |v, i|
			"<element id=\"#{i}\">#{v}</element>"
		}.join +
		"</array>"
	end
end

children = [] of Process
begin
	a = [0, 2, 4, 6, 8]
	children = [
		serve(HOST, PORT, ->(c : HTTP::Request) { a.to_json }),
		serve(HOST, PORT + 1, ->(c : HTTP::Request) { a.reverse.to_xml }, "application/xml")
	]
	sleep 1
	print_from HOST, PORT
	print_from HOST, PORT + 1
ensure
	children.each &.kill
end