require "./11b.include"

child = fork_task do |parent|
	f = ->(socket : TCPSocket) do
		[0, 2, 4, 6, 8].each do |v|
			socket.puts v
		end
	end
	server = TCPServer.new HOST, PORT
	parent.puts
	loop do
		socket = server.accept
		spawn do
			f.call socket
			socket.close
		end
	end
end

i = 0
TCPSocket.open HOST, PORT do |in|
	in.each_line do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end

child.kill