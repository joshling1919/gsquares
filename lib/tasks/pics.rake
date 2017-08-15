require 'watir'
require 'watir/wait'

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
      next if file == '.' || file == '..' || file == '.DS_Store'

      name = file.split(' ')[0, 2].join(' ')

      search.set name 

      search_results = browser.lis(class: 'show')
      if search_results.count < 1
        error_students << name
      else
        # if search_results.count > 1
        #   # In this case, the user has to manually choose the 
        #   # correct student in order for the rest of the script
        #   # to continue running. The Watir timer will wait 5000
        #   # seconds for the user (over an hour).
        #   Watir::Wait.while(5000) { browser.lis(class: 'show').count > 0 }
        # else
          browser.send_keys :enter
        # end
        browser.a(class: 'button', text: 'Edit Student').click 
        rel_path = 'lib/pics/' + file
        abs_path = File.absolute_path(rel_path)
        browser.file_field(id: 'student_avatar', type: 'file').set(abs_path)
        browser.button(text: 'Submit').click
      end

    end

    puts "Uploaded Pictures!"
    puts "Unable to upload pics for:"
    error_students.each do |name|
      puts name
    end
  end
end
