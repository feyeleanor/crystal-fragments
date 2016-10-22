def print(s : Object)
	case s
	when Array
		s.each_with_index do |v, i|
			puts "#{i}: #{v}"
		end
	end
end

print [0, 2, 4, 6, 8]