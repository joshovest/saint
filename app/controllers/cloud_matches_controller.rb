class CloudMatchesController < ApplicationController
  # GET /cloud_matches
  # GET /cloud_matches.json
  def index
    @cloud_matches = CloudMatch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cloud_matches }
    end
  end

  # GET /cloud_matches/1
  # GET /cloud_matches/1.json
  def show
    @cloud_match = CloudMatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cloud_match }
    end
  end

  # GET /cloud_matches/new
  # GET /cloud_matches/new.json
  def new
    @cloud_match = CloudMatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cloud_match }
    end
  end

  # GET /cloud_matches/1/edit
  def edit
    @cloud_match = CloudMatch.find(params[:id])
  end

  # POST /cloud_matches
  # POST /cloud_matches.json
  def create
    @cloud_match = CloudMatch.new(params[:cloud_match])

    respond_to do |format|
      if @cloud_match.save
        format.html { redirect_to @cloud_match, notice: 'Cloud match was successfully created.' }
        format.json { render json: @cloud_match, status: :created, location: @cloud_match }
      else
        format.html { render action: "new" }
        format.json { render json: @cloud_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cloud_matches/1
  # PUT /cloud_matches/1.json
  def update
    @cloud_match = CloudMatch.find(params[:id])

    respond_to do |format|
      if @cloud_match.update_attributes(params[:cloud_match])
        format.html { redirect_to @cloud_match, notice: 'Cloud match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cloud_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloud_matches/1
  # DELETE /cloud_matches/1.json
  def destroy
    @cloud_match = CloudMatch.find(params[:id])
    @cloud_match.destroy

    respond_to do |format|
      format.html { redirect_to cloud_matches_url }
      format.json { head :no_content }
    end
  end
end
