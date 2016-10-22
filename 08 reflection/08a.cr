def print(s : Object)
	case s
	when Proc(Int32, Int32)
		(0...5).each do |i|
			puts "#{i}: #{s.call i}"
		end
	when Array
		s.each_with_index do |v, i|
			puts "#{i}: #{v}"
		end
	end
end

s = [0, 2, 4, 6, 8]
print s
print ->(i : Int32) {
	s[i]
}