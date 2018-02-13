class CreateGossips < ActiveRecord::Migration[5.1]
  def change
    create_table :gossips do |t|
      t.text :content
      t.references :moussaillon
      t.timestamps
    end
  end
end
