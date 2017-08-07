# GSquares

## Adding new students
In order to auto add new students:

1. Install chromedriver by running `brew install chrome driver`
2. Run the student update rake task: `rake update:students`
3. Copy the contents of `final.csv` into `seeds_data.csv` 
4. Push to heroku and run `heroku run rake db:seed`

Things to keep in mind:
* Before updating students, add the new cohort enum in student model.
* Update the student update rake task to reflect the new cohort.
* If there is a previous `final.csv` delete it before running student update.
* After seeding heroku, run `heroku run rake github:update` to fetch green squares.