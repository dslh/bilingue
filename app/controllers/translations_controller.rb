class TranslationsController < ApplicationController
  # GET /phrases/1/translations
  # GET /phrases/1/translations.json
  def index
    @phrases = Phrase.find(params[:phrase_id]).translations

    respond_to do |format|
      format.html { render 'phrases/index' }
      format.json { render json: @phrases }
    end
  end

  # GET /phrases/1/translations/2
  # GET /phrases/1/translations/2.json
  def show
    @phrase = Phrase.find(params[:phrase_id]).translations.find(params[:id])

    respond_to do |format|
      format.html { render 'phrases/show' }
      format.json { render json: @phrase }
    end
  end

  # POST /phrases/1/translations
  # POST /phrases/1/translation.json
  def create
    @phrase = Phrase.find(params[:phrase_id])
    @translation = @phrase.translations.create(params[:translation])
    @translation.set_tags params[:tags]

    respond_to do |format|
      if @translation.save
        format.html {redirect_to @phrase, notice: 'Translation added successfully.' }
        format.json { render json: @translation, status: :created, location: @translation }
        format.js { render :partial => 'phrases/translation_listing', :content_type => 'text/html', :locals => { :translation => @translation } }
      else
        format.html { render json: @translation.errors, status: :unprocessable_entity }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
        format.js { render 'common/errors', :locals => { :errors => @translation.errors } }
      end
    end
  end

  # PUT /phrases/1/translations/2
  # PUT /phrases/1/translations/2.json
  def update
    @phrase = Phrase.find(params[:phrase_id])
    @translation = Phrase.find(params[:id])

    respond_to do |format|
      if @translation.update_attributes(params[:translation])
        format.html { redirect_to @phrase, notice: 'Translation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phrases/1/translations/2
  # DELETE /phrases/1/translations/2.json
  def destroy
    @phrase = Phrase.find(params[:phrase_id])
    @translation = Phrase.find(params[:id])
    @phrase.translations.destroy

    respond_to do |format|
      format.html { redirect_to phrase_url @phrase }
      format.json { head :no_content }
    end
  end
end
