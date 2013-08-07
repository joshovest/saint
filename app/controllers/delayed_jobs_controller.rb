class SitesController < ApplicationController
  def index
    @sites = Site.paginate(page: params[:page])
    
    @c = Classification.new({key: "SEO|Google|salesforce"})
  end
  
  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
    @site.suite_list = @site.prep_list_for_form
  end

  def create
    @site = Site.new(params[:site])
    
    if @site.save
      flash[:success] = 'Site (' + params[:site][:name] + ') has been successfully created.'
      redirect_to sites_path
    else
      render 'new'
    end
  end

  def update
    @site = Site.find(params[:id])
    
    if @site.update_attributes(params[:site])
      flash[:success] = 'Site (' + params[:site][:name] + ') has been successfully updated.'
      redirect_to sites_path
    else
      render 'edit'
    end
  end

  def destroy
    Site.find(params[:id]).destroy
    
    flash[:success] = 'Site (' + @site.name + ') has been successfully deleted.'
    redirect_to sites_path
  end
end
