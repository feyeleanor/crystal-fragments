class MyArray
	def initialize(elements = 0)
		@array = Array(Int32).new(elements)
	end

	def <<(v)
		@array.<< v
	end

	def each_with_index
		i = 0
		@array.each do |v|
			yield v, i
		end
	end

	def replace(a)
		@array.replace a
		self
	end
end

s = MyArray.new.replace [0, 2, 4, 6, 8]
s.each_with_index do |v, i|
	puts "#{i}: #{v}"
end

def if_iterable?(o, &block)
	if o.responds_to? :each_with_index
		o.each_with_index do |v, i|
			yield v, i
		end
	end
end

if_iterable? s do |v, i|
	puts "#{i}: #{v}"
end