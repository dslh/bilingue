class PhrasesController < ApplicationController
  # GET /phrases
  # GET /phrases.json
  def index
    @phrases = Phrase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phrases }
    end
  end

  # GET /phrases/1
  # GET /phrases/1.json
  def show
    @phrase = Phrase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phrase }
    end
  end

  # GET /phrases/new
  # GET /phrases/new.json
  def new
    @phrase = Phrase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phrase }
    end
  end

  # GET /phrases/1/edit
  def edit
    @phrase = Phrase.find(params[:id])
  end

  # POST /phrases
  # POST /phrases.json
  def create
    @phrase = Phrase.new(params[:phrase])
    @phrase.categories = params[:tags]

    respond_to do |format|
      existing = Phrase.where{{
        :phrase => my{@phrase.phrase},
        :language_id => my{@phrase.language_id}
      }}
      if not existing.empty?
        @phrase = existing[0]
        format.html { redirect_to @phrase, notice: 'Phrase already exists.' }
        format.json { render json: @phrase, status: :accepted, location: @phrase }
        format.js { render :partial => 'listing', :content_type => 'text/html', :locals => { :phrase => @phrase } }
      elsif @phrase.save
        format.html { redirect_to @phrase, notice: 'Phrase was successfully created.' }
        format.json { render json: @phrase, status: :created, location: @phrase }
        format.js { render :partial => 'listing', :content_type => 'text/html', :locals => { :phrase => @phrase } }
      else
        format.html { render action: "new" }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
        format.js { render 'common/errors', :locals => { :errors => @phrase.errors } }
      end
    end
  end

  # PUT /phrases/1
  # PUT /phrases/1.json
  def update
    @phrase = Phrase.find(params[:id])
    @phrase.categories = params[:tags] if params[:tags]

    respond_to do |format|
      if @phrase.update_attributes(params[:phrase])
        format.html { redirect_to @phrase, notice: 'Phrase was successfully updated.' }
        format.json { head :no_content }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
        format.js { render 'common/errors', :locals => { :errors => @phrase.errors } }
      end
    end
  end

  # DELETE /phrases/1
  # DELETE /phrases/1.json
  def destroy
    @phrase = Phrase.find(params[:id])
    @phrase.destroy

    respond_to do |format|
      format.html { redirect_to phrases_url }
      format.json { head :no_content }
      format.js {head :no_content }
    end
  end
end


