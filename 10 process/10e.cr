require "./10e.include"

array = ->(out : IO::FileDescriptor) do
	(0...5).to_a.map { |v|
		v * 2
	}.each { |v|
		out.puts v
	}
end

print IPCArray.new &array

print IPCArray.new { |out|
	(0...5).to_a.reverse.map { |v|
		v * 2
	}.each { |v|
		out.puts v
	}
}

print IPCArray.new &->(out : IO::FileDescriptor) do
	(0...5).to_a.map { |v|
		v * 2
	}.each { |v|
		out.puts v
	}
end