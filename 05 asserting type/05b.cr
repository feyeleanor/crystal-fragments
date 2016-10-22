def print(s : Object)
	case
	when s.responds_to?(:each_with_index)
		s.each_with_index do |v, i|
			puts "#{i}: #{v}"
		end
	end
end

print [0, 2, 4, 6, 8]