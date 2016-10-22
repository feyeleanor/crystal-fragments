class Channel
	def each(&block)
		loop do
			yield self.receive
		end rescue ClosedError
	end

	def each_with_index(&block)
		i = 0
		loop do
			yield self.receive, i
			i += i
		end rescue ClosedError
	end
end

def print(chan)
	chan.each_with_index do |v, i|
		puts "#{i}: #{v}"
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