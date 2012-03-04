class LanguagesController < ApplicationController
  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all

    respond_to do |format|
      format.html
      format.json { render json: @languages }
    end
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
    @language = Language.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @language }
    end
  end

end
