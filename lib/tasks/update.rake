require 'nokogiri'
require 'watir'
require 'csv'

namespace :update do 
  desc "Update users" 
  task students: :environment do
    browser = Watir::Browser.new(:chrome)
    browser.goto('http://progress.appacademy.io/')
    email = browser.text_field id: 'instructor_email'
    email.set 'jling@appacademy.io'
    pw = browser.text_field id: 'instructor_password'
    pw.set ENV['jw_pw']
    browser.button(text: 'Sign In').click

    search = browser.text_field id: 'student-search'
    CSV.open('final.csv', "wb") do |new_csv|
      CSV.foreach('lib/tasks/gsquares.csv') do |row|
        search.set row[0]
        browser.send_keys :enter
        name = row[0]
        email = row[1]
        cohort = 5
        if row[2] == "5/29/2017"
          cohort = 6
        end
        coach = 0

        if search.exists?
          page = Nokogiri::HTML(browser.html)
          contact_info = page.css('.contact-info').css('tr')
          github_link = contact_info[4].css('a')[0].attributes['href'].value
          github = github_link[18, github_link.length - 1]
          student_image = page.css('img')[0].attributes['src'].value
          student_image = 'http:' + student_image 
          new_csv << [name, email, cohort, coach, github, student_image]
        else
          new_csv << [name, email, cohort, coach, 'github unknown', 'image_url']
          browser.back 
        end
      end
    end

    puts "Added new students!"
  end
end
