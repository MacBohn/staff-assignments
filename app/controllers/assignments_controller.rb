class AssignmentsController < ApplicationController

  def new
    @person = Person.find(params[:person_id])
    @assignment = @person.assignments.new
  end

  def create
    @person = Person.find(params[:person_id])
    @assignment = @person.assignments.new(assignment_params)
    if @assignment.save
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  def update
    @person = Person.find(params[:person_id])
    @assignment = @person.assignments.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to person_path(@person)
    else
      render :edit
    end
  end

  def edit
    @person = Person.find(params[:person_id])
    @assignment = @person.assignments.find(params[:id])
  end
  def destroy
    @person = Person.find(params[:person_id])
    @assignment = @person.assignments.find(params[:id])
    if @assignment.destroy
      redirect_to person_path(@person)
    end
  end


  def assignment_params
    params.require(:assignment).permit(:role, :location_id)
  end

end
