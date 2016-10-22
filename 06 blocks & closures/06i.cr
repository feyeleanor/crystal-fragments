def array(&block)
	(0...5).each { |i|
		yield i * 2, i
	}
end

array do |v, i|
	puts "#{i}: #{v}"
end