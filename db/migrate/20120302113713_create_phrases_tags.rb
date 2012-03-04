class CreatePhrasesTags < ActiveRecord::Migration
  def change
    create_table :phrases_tags, :id => false do |t|
      t.integer :phrase_id
      t.integer :tag_id
    end
  end
end
