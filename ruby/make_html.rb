require 'json'
require "pp"


class Main
	def initialize
		@diff_types = ["🆕","⬆️", "⬇️", "➡️"]
	end
	def make_ranking(date = "20211203")
		json = File.read("./json/#{date}_ranking.json",encodung:'utf-8')
		json = JSON.parse(json)
		h1 = json['date']
		list = []
		json['ranking'].each do |li|
			html = '<li>'
			html += "#{@diff_types[li['diff_type']]}"
			html += '<i>' + li['ranking'].to_s + '</i>'
			html += '<a href="https://www.figma.com/community/plugin/' + li["plugin_id"].to_s + '">'
			html += li['plugin_name'] + '</a>'
			html += ' <b>(' + li['diff_count'].to_s + 'DL)</b>'
			html += '</li>'
			list.push(html)
		end
		base = File.read("./template/temp.html",encodung:'utf-8')
		temp = base.gsub('<!--title-->',"Figma Weekly Ranking #{date}")
		temp = temp.gsub('<!--h1-->',"#{date}")
		temp = temp.gsub('<!--ul-->',list.join("\n"))
		File.open("./#{date}.html","w") do |f|
			f.puts(temp)
		end
	end
end


main = Main.new().make_ranking()