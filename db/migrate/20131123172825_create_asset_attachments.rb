class CreateAssetAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :assetable_asset_attachments do |t|
      t.references :asset, index: false
      t.references :assetable, :polymorphic => true, index: false
      t.string :name
      t.timestamps
    end

    add_index(:assetable_asset_attachments, :asset_id)
    add_index(:assetable_asset_attachments, [:assetable_type, :assetable_id], name: "assetable_asset_attachments_poly_asset_attachment")
    add_index(:assetable_asset_attachments, [:assetable_type, :assetable_id, :name], unique: true, name: "assetable_asset_attachments_poly_named_asset")
    add_index(:assetable_asset_attachments, :assetable_id, name: "assetable_asset_attachments_assetable_id")
  end
end