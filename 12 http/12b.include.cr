require "http/server"
require "json"

HOST = "localhost"
PORT = 1234

def print_from(host, port)
	i = 0
	read_from(host, port) do |v|
		puts "#{i}: #{v}"
		i += 1
	end
end
