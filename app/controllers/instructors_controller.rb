class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    # GET '/instructors' with customised JSON
    def index
        instructors = Instructor.all
        render json: instructors, each_serializer: InstructorSerializer, status: :ok
    end

    # GET '/instructors/:id' with customised JSON
    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    # POST '/instructors'
    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    # PATCH '/instructors/:id'
    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :ok
    end

    # DELETE '/instructors/:id'
    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private
    def instructor_params
        params.permit(:name)
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_record_not_found
        render json: { error: "Instructor not found" }, status: :not_found
    end
end
