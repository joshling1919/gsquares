# == Schema Information
#
# Table name: students
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  email          :string           not null
#  image_url      :string
#  github_squares :string
#  cohort         :integer          default("0")
#  coach          :integer          default("0")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  github         :string
#

class Student < ApplicationRecord
    validates :name, :email, :cohort, :coach, presence: true
    validates :email, uniqueness: true

    enum cohort: [  
        'May 2016',
        'July 2016',
        'September 2016',
        'November 2016',
        'January 2017',
        'March 2017'
    ]

    enum coach: [
        :Josh,
        :Andrew,
        :Eli,
        :Laura
    ]
end
