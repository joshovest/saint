class BrandMatchesController < ApplicationController
  # GET /brand_matches
  # GET /brand_matches.json
  def index
    @brand_matches = BrandMatch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brand_matches }
    end
  end

  # GET /brand_matches/1
  # GET /brand_matches/1.json
  def show
    @brand_match = BrandMatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand_match }
    end
  end

  # GET /brand_matches/new
  # GET /brand_matches/new.json
  def new
    @brand_match = BrandMatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand_match }
    end
  end

  # GET /brand_matches/1/edit
  def edit
    @brand_match = BrandMatch.find(params[:id])
  end

  # POST /brand_matches
  # POST /brand_matches.json
  def create
    @brand_match = BrandMatch.new(params[:brand_match])

    respond_to do |format|
      if @brand_match.save
        format.html { redirect_to @brand_match, notice: 'Brand match was successfully created.' }
        format.json { render json: @brand_match, status: :created, location: @brand_match }
      else
        format.html { render action: "new" }
        format.json { render json: @brand_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /brand_matches/1
  # PUT /brand_matches/1.json
  def update
    @brand_match = BrandMatch.find(params[:id])

    respond_to do |format|
      if @brand_match.update_attributes(params[:brand_match])
        format.html { redirect_to @brand_match, notice: 'Brand match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brand_matches/1
  # DELETE /brand_matches/1.json
  def destroy
    @brand_match = BrandMatch.find(params[:id])
    @brand_match.destroy

    respond_to do |format|
      format.html { redirect_to brand_matches_url }
      format.json { head :no_content }
    end
  end
end
