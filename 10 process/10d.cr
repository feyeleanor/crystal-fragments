class IPCArray
	@pipe : IO::FileDescriptor

	def initialize
		@pipe, w = IO.pipe true, true
		@process = Process.fork do
			@pipe.close
			yield w
			w.close
			exit 0
		end
		w.close
	end

	def pid
		@process.pid
	end

	def each_with_index
		i = 0
		@pipe.each_line { |v|
			yield v, i
			i += 1
		}
	end
end

def array
	IPCArray.new do |out|
		(0...5).to_a.map { |v|
			v * 2
		}.each { |v|
			out.puts v
		}
	end
end

def print(a : IPCArray)
	puts "reading from pid: #{a.pid}"
	a.each_with_index do |v, i|
		puts "#{i}: #{v}"
	end
end

print array
print array