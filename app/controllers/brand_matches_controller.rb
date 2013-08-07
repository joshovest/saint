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
    @brand_match.position = BrandMatch.count + 1 if @brand_match.position.nil?
    
    if @brand_match.save
      flash[:success] = 'Match has been successfully created.'
      redirect_to brand_matches_path
    else
      render 'new'
    end
  end

  def update
    @brand_match = BrandMatch.find(params[:id])
    @brand_match.position = BrandMatch.count + 1 if @brand_match.position.nil?

    if @brand_match.update_attributes(params[:brand_match])
      flash[:success] = 'Match has been successfully updated.'
      redirect_to brand_matches_path
    else
      render 'edit'
    end
  end

  def destroy
    BrandMatch.find(params[:id]).destroy

    flash[:success] = 'Match has been successfully deleted.'
    redirect_to brand_matches_path
  end
  
  def upload
    @upload_file = UploadFile.new
  end
  
  def process_upload
    @upload_file = UploadFile.new
    if !params[:upload_file].nil?
      @upload_file.filename = params[:upload_file][:filename].original_filename
      @path = @upload_file.save_file(params[:upload_file][:filename])
    end
    
    if @upload_file.save && @path
      require 'csv'
      
      count = 0
      deleted = false
      CSV.foreach(@path, :col_sep => ",") do |row|
        # skip column headings
        if count != 0
          match = BrandMatch.new
          match.match_list = row[0]
          match.exclude_list = row[1]
          if match.valid?
            if !deleted
              # start all over
              BrandMatch.destroy_all
              deleted = true
            end
            match.position = BrandMatch.count + 1
            match.save
          end
        end
        count += 1
      end
      
      #delete file
      
      flash[:success] = "Your file was uploaded successfully!"
      redirect_to brand_matches_path
    else
      render "upload"
    end
  end
  
  def sort
    @brand_matches = BrandMatch.all
    @brand_matches.each do |match|
      match.position = params['match'].index(match.id.to_s) + 1
      match.save
    end
  
    render nothing: true
  end
end
