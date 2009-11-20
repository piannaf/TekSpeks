class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.string :abbrev
      t.integer :type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
