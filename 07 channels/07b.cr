class Channel
	def each(&block)
		loop do
			yield self.receive
		end rescue ClosedError
	end
end

def print(chan)
	i = 0
	chan.each do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end

c = Channel(Int32).new
spawn do
	[0, 2, 4, 6, 8].each do |v|
		c.send v
	end
	c.close
end

print c