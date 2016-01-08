require "jumpstart_auth"
require "bitly"
Bitly.use_api_version_3

class MicroBlogger

	attr_reader :client, :screen_names

	def initialize
		puts "Initializing... "
		@client = JumpstartAuth.twitter
		@screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
	end

	def tweet(message)
		@client.update(message)
	end

	def run
		puts "welcom to the twitter"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
			when "q" then puts "later"
			when "t" then tweet(parts[1..-1].join(" "))
			when "dm" then dm(parts[1], parts[2..-1].join(" "))
			when "spam" then spam_my_followers(parts[1..-1].join(" "))
			when "elt" then all_last_tweet
			when "turl" then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
			else 
				puts "dunno how to #{command}"
			end
		end
	end

	def followers_list
		names = []
		@client.followers.each {|x| names << @client.user(x).screen_name}
		return names
	end

	def spam_my_followers(message)
		self.followers_list.each{|x| dm(x, message)}
	end

	def all_last_tweet
		friends = @client.friends
		friends = friends.map { |friend| @client.user(friend)}
		friends.sort!
		friends.each do |friend|
			puts "@" + friend.screen_name + ": " + friend.status.text + " -- " + friend.status.created_at.strftime("%A, %b %d")
		end
	end

	def dm(target, message)
		if screen_names.include?(target)
			puts "sending #{target} this message"
			puts message
			message = "d @#{target} #{message}"
			tweet(message)
		else puts "not follower"
		end
	end

	def shorten(original_url)
		puts "shortening #{original_url}"
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		return bitly.shorten(original_url).short_url
	end
end

blogger = MicroBlogger.new
blogger.run
