class Array
	def print
		self.each_with_index do |v, i|
			puts "#{i}: #{v}"
		end
	end
end

[0, 2, 4, 6, 8].self &.print
