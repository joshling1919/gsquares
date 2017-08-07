class StudentsController < ApplicationController
    def index
      @students = Student.all.order(:cohort)
    end

    def josh 
      @students = filter_coach(0)
      render :index
    end 

    def andrew 
      @students = filter_coach(0)
      render :index
    end
    
    def eli 
      @students = filter_coach(2)
      render :index
    end
    
    def laura
      @students = filter_coach(3)
      render :index
    end

    def destroy
      @student = Student.find(params[:id])
      
      @student.destroy!
      
      respond_to do |format|
        format.js
      end
    end

    private

    def filter_coach(coach_id)
      Student.where(coach: coach_id).order(:cohort)
    end
end
