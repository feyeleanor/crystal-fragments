class MyArray
	include Enumerable(Object)

	def initialize(elements = 0)
		@array = Array(Int32).new(elements)
	end

	def <<(v)
		@array.<< v
	end

	def each
		@array.each do |v|
			yield v
		end
	end

	def replace(a)
		@array.replace a
		self
	end
end

a = [0, 2, 4, 6, 8]
s = MyArray.new.replace a
[a, s].each do |x|
	a.each_with_index do |v, i|
		puts "#{i}: #{v}"
	end
end

def if_iterable?(o, &block)
	case o
	when Enumerable
		if o.responds_to? :each_with_index
			o.each_with_index do |v, i|
				yield v, i
			end
		end
	when Array
		# this never runs because Arrays are Enumerable
		puts "preventing Arrays from printing"
	end
end

[a, s].each do |x|
	if_iterable? x do |v, i|
		puts "#{i}: #{v}"
	end
end