class CloudMatchesController < ApplicationController
  def index
    @cloud_matches = CloudMatch.order('cloud_matches.position ASC, id')
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
    @cloud_match.position = CloudMatch.all.length + 1 if @cloud_match.position.nil?
    
    if @cloud_match.save
      flash[:success] = 'Match has been successfully created.'
      redirect_to cloud_matches_path
    else
      render 'new'
    end
  end

  def update
    @cloud_match = CloudMatch.find(params[:id])
    @cloud_match.position = CloudMatch.all.length + 1 if @cloud_match.position.nil?
    
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
  
  def upload
  end
  
  def sort
    @cloud_matches = CloudMatch.all
    @cloud_matches.each do |match|
      match.position = params['match'].index(match.id.to_s) + 1
      match.save
    end
  
    render nothing: true
  end
end
