class PostesController < ApplicationController
  def new
    @poste = Poste.new
  end

  def create
    @poste = Poste.new(poste_params)
    @poste.save
    redirect_to postes_path
  end

  def edit
    @poste = Poste.find(params[:id])
  end

  def update
    @poste = Poste.find(params[:id])
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
