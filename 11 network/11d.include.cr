require "socket"

HOST = "localhost"
PORT = 1234

def fork_task
	child, parent = IO.pipe true, true
	p = Process.fork do
		child.close
		yield parent
		parent.close
		exit 0
	end
	parent.close
	child.gets
	child.close
	p
end

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
	TCPSocket.open(host, port) do |in|
		in.each_line do |v|
			puts "#{i}: #{v}"
			i += 1
		end
	end
end