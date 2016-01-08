require 'socket'
require 'json'
server = TCPServer.open(2000)
loop {
	client = server.accept
	request = client.gets
	length = client.gets
	hash = client.gets
	type = request.split(" ")
	type = type[0]
	case type
	when "GET"
		a = request[1]
		a = a[1..-1]
		if File.exist?(a)
			response = []
			response[0] = "200 bueno\n" 
			response << File.readlines(a)
		else
			response = "404 not found: #{a}"
		end
	when "POST"
		params = JSON.parse(hash, opts = {:symbolize_names => true})
		li =  ["<li>name: " + params[:viking][:name] + "</li>", "<li>email: " + params[:viking][:email] + "</li>"]
		a = []
		a << File.readlines("thanks.html")
		c = a.to_s
		newline = c.gsub("<%= yield %>", li[0] + li[1])
		response = newline
	else 
		response = "invalid request"
	end
	client.puts response
	client.close
}
