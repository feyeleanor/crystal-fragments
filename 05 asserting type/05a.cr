def print(s : Object)
	if s.is_a?(Array)
		s.each_with_index do |v, i|
			puts "#{i}: #{v}"
		end
	end
end

print [0, 2, 4, 6, 8]