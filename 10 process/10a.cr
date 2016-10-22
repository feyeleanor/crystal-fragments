in, out = IO.pipe true, true
Process.fork do
	in.close
	[0, 2, 4, 6, 8].each { |v|
		out.puts v
	}
	out.close
	exit 0
end
out.close

i = 0
in.each_line do |v|
	puts "#{i}: #{v}"
	i += 1
end