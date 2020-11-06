class AddKindToUpdateBatches < ActiveRecord::Migration[6.0]
  def change
    add_column :update_batches, :kind, :string
    add_index :update_batches, :kind
  end
end
