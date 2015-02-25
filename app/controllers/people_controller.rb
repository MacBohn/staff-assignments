class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params.require(:person).permit(:first_name, :last_name, :title))
    if @person.save
      redirect_to root_path, notice: "Person was created!"
    else
      render :new
    end
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(params.require(:person).permit(:first_name, :last_name, :title))
      redirect_to people_path
    else
      render :edit
    end
  end

end
