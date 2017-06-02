require 'csv'

CSV.foreach('./db/seeds_data.csv') do |row|
  Student.create!(
    name: row[0],
    email: row[1],
    cohort: row[2].to_i,
    coach: row[3].to_i,
    github: row[4],
    image_url: row[5]
  )
end