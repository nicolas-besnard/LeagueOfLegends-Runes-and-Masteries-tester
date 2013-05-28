require 'rubygems'
require 'nokogiri'   
require 'open-uri'

class GetInfos
	def initialize(content)
		@content = content
		@i = 0
		@totalElem = @content.size
		@name = nil;
		@file = File.open("value.txt", "w")
	end

	def parse
		for	j in 1...@totalElem
			puts 'NEWS => '
			if @content[j].css('td')[0]['id']
				getContentWithType(@content[j].css('td'))
			else
				getContent(@content[j].css('td'))
			end
			puts '<= END'
			puts j
		end
		@file.close	
	end

	def getContent(value)
		nb = 0
		tier = 1;
		puts "NAMME ==> #{@name}"
		value.css('td').each { |v|
			if nb == 0
				print 'Type :'
				puts v.css('b').text
				if v.css('p').css('a').css('img').length > 0 #if not runes not available
					print 'Image : '
					puts v.css('p').css('a').css('img').length
					puts v.css('p').css('a').css('img')[0]['data-image-name']
				end
				nb += 1
			elsif v.css('b').text.length > 0
				print "T#{tier} v : =>"
				puts v.css('b').text
				print "T#{tier} price :"
				puts v.css('p').css('b').text
				tier += 1
			end			
		}
	end

	def getContentWithType(value)
		nb = 0;
		value.css('td').each { |v|
			if nb == 0
				@file.write("\n\nName : #{v.css('b').text}\n")
				print 'Name : '
				puts v.css('b').text
				@name = v.css('b').text
			elsif nb == 1
				print 'Type : '
				puts v.css('b').text
				@file.write("Type : #{v.css('b').text}\n")
				if v.css('p').css('a').css('img').length > 0 # if seal not available
					print 'Image : '
					puts v.css('p').css('a').css('img')[0]['data-image-name']
					@file.write("Image : #{v.css('p').css('a').css('img')[0]['data-image-name']}\n")
				end
			else
				if v.css('b').text.length > 0
					@file.write("T#{nb - 1} value : #{v.css('b').text}\n")
					@file.write("T#{nb - 1} : #{v.css('p').css('b').text}\n")
					print "T#{nb - 1} v :"
					puts v.css('b').text
					print "T#{nb - 1} price :"
					puts v.css('p').css('b').text
				end
			end
			nb += 1
		}
	end
end

page = Nokogiri::HTML(open("http://leagueoflegends.wikia.com/wiki/List_of_runes"))   
infos = GetInfos.new(page.css('table')[1].css('tr')).parse

