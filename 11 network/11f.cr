require "./11f.include"

def serve_reversed_array_at(host, port)
	reversed_array_at HOST, PORT + 1
	yield read_from(HOST, PORT + 1)
	Process.exit
end

serve HOST, PORT, ->(socket : TCPSocket) {
	serve_reversed_array_at HOST, PORT + 1 do |a|
		a.each { |v| socket.puts v }
	end
}
print_from HOST, PORT

serve HOST, PORT, ->(socket : TCPSocket) {
	serve_reversed_array_at HOST, PORT + 1 do |a|
		a.reverse_each { |v| socket.puts v }
	end
}
print_from HOST, PORT