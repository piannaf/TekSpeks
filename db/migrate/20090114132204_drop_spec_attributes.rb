class DropSpecAttributes < ActiveRecord::Migration
  def self.up
    drop_table(:spec_attributes)
  end

  def self.down
    create_table :spec_attributes do |t|
      t.string :name

      t.timestamps
    end
  end
end
