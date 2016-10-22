def array
	in, out = IO.pipe true, true
	p = Process.fork do
		in.close
		(0...5).to_a.map { |v|
			v * 2
		}.each { |v|
			out.puts v
		}
		out.close
		exit 0
	end
	out.close
	puts "reading from pid: #{p.pid}"
	in
end

def print(in)
	i = 0
	in.each_line do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end

print array
print array