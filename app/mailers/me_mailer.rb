class MeMailer < ApplicationMailer
  def notify_email(students)
    @students = students
    mail(to: 'jling@appacademy.io', subject: 'Students who failed to email')
  end
end
