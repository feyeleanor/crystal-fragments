def print(a : Object)
	case a
	when Proc(Int32, Int32)
		(0...5).each do |i|
			puts "#{i}: #{a.call(i)}"
		end
	end
end

s = [0, 2, 4, 6, 8]
print ->(i : Int32) {
	s[i]
}
