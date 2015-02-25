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


def assignment_params
  params.require(:assignment).permit(:role, :location_id)
end

end
