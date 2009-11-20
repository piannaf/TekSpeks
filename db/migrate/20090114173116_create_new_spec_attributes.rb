class CreateNewSpecAttributes < ActiveRecord::Migration
  def self.up
    create_table :spec_attributes do |t|
      t.string :name
      t.integer :type_id

      t.timestamps
    end
  end

  def self.down
    drop_table(:spec_attributes)
  end
end
