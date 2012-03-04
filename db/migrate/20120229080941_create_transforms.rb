class CreateTransforms < ActiveRecord::Migration
  def change
    create_table :transforms do |t|
      t.string :type
      t.integer :phrase_id
      t.integer :transformation_id

      t.timestamps
    end
  end
end
