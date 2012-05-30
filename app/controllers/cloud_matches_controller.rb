class CloudMatchesController < ApplicationController
  def index
    @cloud_matches = CloudMatch.all
  end

  def new
    @cloud_match = CloudMatch.new
  end

  def edit
    @cloud_match = CloudMatch.find(params[:id])
    @cloud_match.match_list = @cloud_match.prep_list_for_form
  end

  def create
    @cloud_match = CloudMatch.new(params[:cloud_match])
    
    if @cloud_match.save
      flash[:success] = 'Match has been successfully created.'
      redirect_to cloud_matches_path
    else
      render 'new'
    end
  end

  def update
    @cloud_match = CloudMatch.find(params[:id])
    
    if @cloud_match.update_attributes(params[:cloud_match])
      flash[:success] = 'Match has been successfully updated.'
      redirect_to cloud_matches_path
    else
      render 'edit'
    end
  end

  def destroy
    @cloud_match = CloudMatch.find(params[:id])
    @cloud_match.destroy
    
    CloudMatch.find(params[:id]).destroy
    
    flash[:success] = 'Match has been successfully deleted.'
    redirect_to cloud_matches_path
  end
end
