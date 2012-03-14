class QuizzesController < ApplicationController
  # GET /quizzes/tag+tag2/20
  def show
    @tags = params[:tags].split('+')
    @language = Language.find(params[:language])
    @phrases = @language.phrases.tagged_with(@tags)
    length = [params[:length].to_i || 10, @phrases.length].min
    @phrases = @phrases.shuffle[0...length]

    respond_to do |format|
      format.html { render 'quiz' }
    end
  end

  # GET /quizzes/new
  def new
    @tags = RocketTag::Tag.all

    respond_to do |format|
      format.html { render 'new' }
    end
  end
end
