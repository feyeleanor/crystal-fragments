require "./11b.include"

def serve(host, port, f : Proc(TCPSocket, NoReturn))
	fork_task do |parent|
		server = TCPServer.new host, port
		parent.puts
		loop do
			socket = server.accept
			spawn do
				f.call socket
				socket.close
			end
		end
	end
end

def print_from(host, port)
	i = 0
	TCPSocket.open host, port do |in|
		in.each_line do |v|
			puts "#{i}: #{v}"
			i += 1
		end
	end
end

child = serve HOST, PORT, ->(socket : TCPSocket) {
	[0, 2, 4, 6, 8].each do |v|
		socket.puts v
	end
	Process.exit
}
print_from HOST, PORT