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

def reversed_array_at(host, port)
	a = [0, 2, 4, 6, 8]
	serve host, port, ->(socket : TCPSocket) {
		a.reverse_each { |v| socket.puts v }
		Process.exit
	}
end

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
