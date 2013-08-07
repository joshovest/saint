class CloudsController < ApplicationController
  def index
    @clouds = Cloud.paginate(page: params[:page])
  end

  def new
    @cloud = Cloud.new
  end

  def edit
    @cloud = Cloud.find(params[:id])
  end

  def create
    @cloud = Cloud.new(params[:cloud])
    
    if @cloud.save
      flash[:success] = 'Cloud (' + params[:cloud][:name] + ') has been successfully created.'
      redirect_to clouds_path
    else
      render 'new'
    end
  end

  def update
    @cloud = Cloud.find(params[:id])
    
    if @cloud.update_attributes(params[:cloud])
      flash[:success] = 'Cloud (' + params[:cloud][:name] + ') has been successfully updated.'
      redirect_to clouds_path
    else
      render 'edit'
    end
  end

  def destroy
    @cloud = Cloud.find(params[:id])
    @cloud.destroy
    
    flash[:success] = 'Cloud (' + @cloud.name + ') and all matches have been successfully deleted.'
    redirect_to clouds_path
  end
end
