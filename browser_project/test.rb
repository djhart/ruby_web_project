require 'json'
name = "butters"
email = "fooooo@barc.om"
hash = {:viking => {:name => name, :email => email}}.to_json
a = JSON.parse(hash, opts = {:symbolize_names => true})
#puts a[:viking][:name]
#b = a.split("\"")
#name_index = b.index("name") + 2 
#email_index = b.index("email") + 2
#puts b(name_index)
b = []
b << File.readlines("thanks.html")
c = b.to_s
newline = c.gsub("<%= yield %>", name)
b << newline
puts newline
