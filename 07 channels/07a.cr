def print(chan)
	i = 0
	loop do
		puts "#{i}: #{chan.receive}"
		i += 1
	end rescue Channel::ClosedError
end

c = Channel(Int32).new
spawn do
	[0, 2, 4, 6, 8].each do |v|
		c.send v
	end
	c.close
end

print c