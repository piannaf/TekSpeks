class AlterSpecAttributesAndUnitsTypeId < ActiveRecord::Migration
  def self.up	
    rename_column(:spec_attributes, :type_id, :attr_type_id)
    rename_column(:units, :type_id, :attr_type_id)
  end

  def self.down
    rename_column(:spec_attributes, :attr_type_id, :type_id)
    rename_column(:units, :attr_type_id, :type_id)
  end
end