s = [0, 2, 4, 6, 8]
begin
	i = 0
	loop
		puts "#{i}: #{s[i]}"
		i += 1
	end
rescue IndexError
end