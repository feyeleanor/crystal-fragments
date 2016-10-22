def print(a : Proc(Int32, Int32))
	i = 0
	while i < 5
		puts "#{i}: #{a.call(i)}"
		i += 1
	end
end

def array
	s = [0, 2, 4, 6, 8]
	->(i : Int32) do
		s[i]
	end
end

print array