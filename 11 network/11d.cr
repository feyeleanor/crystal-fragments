require "./11d.include"

a = [0, 2, 4, 6, 8]
serve HOST, PORT, ->(socket : TCPSocket) {
	a.each { |v| socket.puts v }
	Process.exit
}

serve HOST, PORT + 1, ->(socket : TCPSocket) {
	a.reverse_each { |v| socket.puts v }
	Process.exit
}

print_from HOST, PORT
print_from HOST, PORT + 1