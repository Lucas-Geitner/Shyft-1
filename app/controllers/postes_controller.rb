class PostesController < ApplicationController
  def new
    @poste = Poste.new
    @postes = Poste.all
  end

  def create
    @poste = Poste.new(poste_params)
    @poste.save
    redirect_to new_poste_path
  end

  def edit
    @poste = Poste.find(params[:id])
  end

  def update
    @poste = Poste.find(params[:id])
    @poste.name = params[:name]
    redirect_to new_poste_path
  end

  def destroy
    @poste = Poste.find(params[:id])
    @poste.destroy
    redirect_to(:back)
  end

  def poste_params
    params.require(:poste).permit(:name)
  end
end
