require 'nokogiri'
require 'byebug'

namespace :github do 
  desc "Get update of Students' green squares" 
	task update: :environment do
  	Student.all.each do |student|
    	url = "https://github.com/#{student.github}"
      	begin
        	file = open(url)
          page = Nokogiri::HTML(file)
          squares = page.css(".js-calendar-graph-svg").to_html.html_safe
					student.update!(
						github_squares: squares
					)
        rescue OpenURI::HTTPError => e
        	if e.message == "404 Not Found"
						puts "#{student.name} has an incorrect github handle"
          else
            raise e
          end
        end    
		end
    puts "Students' github squares update!"
  end
end
