class IPCArray
	def initialize(pipe : IO::FileDescriptor, process : Process)
		@pipe = pipe
		@process = process
	end

	def pid
		@process.pid
	end

	def each_line
		@pipe.each_line { |v|
			yield v
		}
	end
end

def create_array
	r, w = IO.pipe true, true
	p = Process.fork do
		r.close
		yield w
		w.close
		exit 0
	end
	w.close
	IPCArray.new r, p
end

def array
	create_array do |out|
		(0...5).to_a.map { |v|
			v * 2
		}.each { |v|
			out.puts v
		}
	end
end

def print(a : IPCArray)
	puts "reading from pid: #{a.pid}"
	i = 0
	a.each_line do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end

print array
print array