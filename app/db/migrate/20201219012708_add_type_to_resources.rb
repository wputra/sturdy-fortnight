class AddTypeToResources < ActiveRecord::Migration[6.1]
  def change
    add_column :resources, :type, :string, null: false, default: ''
  end
end
