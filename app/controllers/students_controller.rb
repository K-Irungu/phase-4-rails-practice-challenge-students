class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    # GET '/students'
    def index
        students = Student.all
        render json: students, each_serializer: StudentSerializer, status: :ok
    end

    # GET '/students/:id'
    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

     # POST '/students'
    def create
        student = Student.create!(student_params)
        render json: student, status: :ok
    end

    # PATCH 'student/:id'
    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :ok
    end

    # DELETE 'students/:id'
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private
    def render_record_not_found
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

end
