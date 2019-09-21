class ImproveFriendlyIdSlugIndexes < ActiveRecord::Migration[6.0]
  def change
    remove_index :friendly_id_slugs, :sluggable_id
    remove_index :friendly_id_slugs, :sluggable_type
    add_index :friendly_id_slugs, %i[sluggable_type sluggable_id]
  end
end
