class QuizzesController < ApplicationController
  # GET /quizzes/language/1/tag+tag2/20
  def show
    @tags = params[:tags].split('+')
    @language = Language.find(params[:language])
# The below code is preferred but at present
# there is an issue with rocket_tag + postgresql.
#    @phrases = @language.phrases.tagged_with(@tags)
#    length = [params[:length].to_i || 10, @phrases.length].min
#    @phrases = @phrases.shuffle[0...length]
    @phrases = Phrase.find_by_sql("
      SELECT * FROM phrases WHERE #{@tags.length} = (
        SELECT count(*) FROM taggings JOIN tags
          ON tags.id = taggings.tag_id
        WHERE tags.name IN (
          #{@tags.collect { |t| "'#{t}'" }.join(',')}
        ) AND taggings.taggable_id = phrases.id
        AND taggings.taggable_type = 'Phrase'
      ) AND language_id=#{@language.id}
      ORDER BY random() LIMIT #{params[:length] || 10}
    ")

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
