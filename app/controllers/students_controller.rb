class StudentsController < ApplicationController
    def index
      @students = Student.all
    end

    def josh 
      @students = Student.where(coach: 0)
      render :index
    end 

    def andrew 
      @students = Student.where(coach: 1)
      render :index
    end
    
    def eli 
      @students = Student.where(coach: 2)
      render :index
    end
    
    def laura
      @students = Student.where(coach: 3)
      render :index
    end
end
