class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name,       null: false
      t.text :description,  null: true

      t.timestamps          null: false
    end
  end
end
