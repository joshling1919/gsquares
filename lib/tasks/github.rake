require 'nokogiri'
require 'byebug'

namespace :github do 
    desc "Get update of Students' green squares" 
    task update: :environment do
        Student.all.each do |student|
            page = Nokogiri::HTML(open('https://github.com/#{student.github}'))
            squares = page.css('.js-calendar-graph-svg').to_html.html_safe
            student.update!(
                github_squares: squares
            )
        end
    end
end