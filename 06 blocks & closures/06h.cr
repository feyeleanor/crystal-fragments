def print(a : Object)
	puts typeof(a)
	case a
	when Array
		(0...5).each do |i|
			puts "#{i}: #{a[i]}"
		end
	when Proc(Int32, (Char | Int32))
		(0...5).each do |i|
			puts "#{i}: #{a.call(i)}"
		end
	end
end

s = [0, 2, 4, 6, 8]
f = ->(i : Int32) {
	s[i]
}
print f
print s

s = "86420"
print f
print s