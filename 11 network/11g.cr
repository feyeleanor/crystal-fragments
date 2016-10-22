require "./11g.include"

class Object
	def write_to(s)
		s.puts self
	end
end

def reversed_array_at(host, port)
	a = [0, 2, 4, 6, 8]
	serve host, port, ->(socket : TCPSocket) {
		a.reverse_each &.write_to socket
		Process.exit
	}
end

def serve_reversed_array_at(host, port)
	reversed_array_at HOST, PORT + 1
	yield read_from(HOST, PORT + 1)
	Process.exit
end

serve HOST, PORT, ->(socket : TCPSocket) {
	serve_reversed_array_at HOST, PORT + 1 do |a|
		a.each &.write_to socket
	end
}
print_from HOST, PORT

serve HOST, PORT, ->(socket : TCPSocket) {
	serve_reversed_array_at HOST, PORT + 1 do |a|
		a.reverse_each &.write_to socket
	end
}
print_from HOST, PORT