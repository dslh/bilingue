class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.text :phrase
      t.belongs_to :language

      t.timestamps
    end
    add_index :phrases, :language_id
  end
end
