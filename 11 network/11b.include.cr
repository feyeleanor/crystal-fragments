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