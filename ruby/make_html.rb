require 'json'
require "pp"


class Main
	def initialize
		@diff_types = ["🆕","⬆️", "⬇️", "➡️"]
	end
	def make_ranking(date = "20211203", ignore_regends = false)
		if (ignore_regends)
			file_name = "#{date}__" 
		else
			file_name = "#{date}_"
		end
		json = File.read("./json/#{file_name}ranking.json",encodung:'utf-8')
		json = JSON.parse(json)
		h1 = json['date']
		list = []
		n = 1
		json['ranking'].each do |li|
			html = '<li>'
			html += "#{@diff_types[li['diff_type']]}"
			if ignore_regends
				html += '<i>' + n.to_s + '</i>'
				n += 1 
			else
				html += '<i>' + li['ranking'].to_s + '</i>'
			end

			html += "<img src=\"https://www.figma.com/community/plugin/#{li["plugin_id"].to_s}/icon\" width=\"32\" height=\"32\">"
			html += '<a href="https://www.figma.com/community/plugin/' + li["plugin_id"].to_s + '">'
			html += li['plugin_name'] + '</a>'
			html += ' <b>(' + li['diff_count'].to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,').reverse + 'DL)</b>'
			html += '</li>'
			list.push(html)
		end

		base = File.read("./template/temp.html",encodung:'utf-8')
		temp = base.gsub('<!--title-->',"Figma Weekly Ranking #{date}")
		temp = temp.gsub('<!--h1-->',"#{date}")
		temp = temp.gsub('<!--ul-->',list.join("\n"))
		File.open("./#{file_name}.html","w") do |f|
			f.puts(temp)
		end
	end
end


main = Main.new().make_ranking(20211203, true)






