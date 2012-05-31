class BrandMatchesController < ApplicationController
  def index
    @brand_matches = BrandMatch.order('brand_matches.position ASC, id')
  end

  def new
    @brand_match = BrandMatch.new
  end

  def edit
    @brand_match = BrandMatch.find(params[:id])
    @brand_match.match_list = @brand_match.prep_match_for_form
    @brand_match.exclude_list = @brand_match.prep_exclude_for_form
  end

  def create
    @brand_match = BrandMatch.new(params[:brand_match])
    @brand_match.position = BrandMatch.all.length + 1 if @brand_match.position.nil?
    
    if @brand_match.save
      flash[:success] = 'Match has been successfully created.'
      redirect_to brand_matches_path
    else
      render 'new'
    end
  end

  def update
    @brand_match = BrandMatch.find(params[:id])
    @brand_match.position = BrandMatch.all.length + 1 if @brand_match.position.nil?

    if @brand_match.update_attributes(params[:brand_match])
      flash[:success] = 'Match has been successfully updated.'
      redirect_to brand_matches_path
    else
      render 'edit'
    end
  end

  def destroy
    BrandMatch.find(params[:id]).destroy

    Site.find(params[:id]).destroy
    
    flash[:success] = 'Match has been successfully deleted.'
    redirect_to brand_matches_path
  end
end
