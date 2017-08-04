require 'nokogiri'
require 'watir'

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
    search.set 'Sonik Jhang'
    browser.send_keys :enter
    page = Nokogiri::HTML(browser.html)
    cohort = page.css('.admin-info').css('li')[0].css('a').text
    contact_info = page.css('.contact-info').css('tr')
    email = contact_info[2].css('a').text
    github_link = contact_info[4].css('a')[0].attributes['href'].value
    student_image = page.css('img')[0].attributes['src'].value


    byebug
    puts "Added new students!"
  end
end
