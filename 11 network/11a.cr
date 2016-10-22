require "socket"

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

child = fork_task do |parent|
	server = TCPServer.new "localhost", 1234
	parent.puts
	server.accept do |client|
		[0, 2, 4, 6, 8].each do |v|
			client.puts v
		end
	end
end

i = 0
TCPSocket.open "localhost", 1234 do |in|
	in.each_line do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end

child.kill