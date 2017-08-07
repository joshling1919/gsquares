require 'watir'

# This rake task does not interact with the gsquares app.
# It is used to automate the picture uploading process for Progress Tracker.
# To properly do this, make sure you have the correct login credentials 
# in the 'email.set' field and in your 'application.yml'.
# Then, make sure that there is a 'pics' directory in the 'lib' directory
# with all of the student pics named properly as 'firstname_lastname.jpeg'.

namespace :pics do 
  desc "Update users" 
  task upload: :environment do
    browser = Watir::Browser.new(:chrome)
    browser.goto('http://progress.appacademy.io/')
    email = browser.text_field id: 'instructor_email'
    email.set 'jling@appacademy.io'
    pw = browser.text_field id: 'instructor_password'
    pw.set ENV['jw_pw']
    browser.button(text: 'Sign In').click

    search = browser.text_field id: 'student-search'

    error_students = []
    Dir.foreach('lib/pics') do |file|
      next if file == '.' || file == '..'
      name_length = file.length 
      name_i = name_length - 5

      name = file[0, name_i].split('_').map(&:capitalize).join(' ')

      search.set name 
      browser.send_keys :enter
      if search.exists?
        browser.a(class: 'button', text: 'Edit Student').click 
        rel_path = 'lib/pics/' + file
        abs_path = File.absolute_path(rel_path)
        browser.file_field(id: 'student_avatar', type: 'file').set(abs_path)
        browser.button(text: 'Submit').click
      else 
        error_students << name
        browser.back                  
      end
    end

    puts "Uploaded Pictures!"
    puts "Unable to upload pics for:"
    error_students.each do |name|
      puts name
    end
  end
end
