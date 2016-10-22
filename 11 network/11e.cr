require "./11d.include"

def read_from(host, port)
	r = [] of String
	TCPSocket.open(host, port) do |in|
		in.each_line { |v| r << v }
	end
	r
end

def print_from(host, port)
	read_from(host, port).each_with_index do |v, i|
		puts "#{i}: #{v}"
	end
end

def reversed_array_at(host, port)
	a = [0, 2, 4, 6, 8]
	serve host, port, ->(socket : TCPSocket) {
		a.reverse_each { |v| socket.puts v }
		Process.exit
	}
end

serve HOST, PORT, ->(socket : TCPSocket) {
	reversed_array_at HOST, PORT + 1
	read_from(HOST, PORT + 1).each do |v|
		socket.puts v
	end
	Process.exit
}
print_from HOST, PORT

serve HOST, PORT, ->(socket : TCPSocket) {
	reversed_array_at HOST, PORT + 1
	read_from(HOST, PORT + 1).reverse_each do |v|
		socket.puts v
	end
	Process.exit
}
print_from HOST, PORT