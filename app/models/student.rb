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

    enum cohort: [  
        :May2016,
        :July2016,
        :September2016,
        :November2016,
    ]

    enum coach: [
        :Josh,
        :Andrew,
        :Eli,
        :Laura
    ]
end
