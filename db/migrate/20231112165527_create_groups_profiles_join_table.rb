class CreateGroupsProfilesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_profiles, id: false do |t|
      t.references :group, foreign_key: true
      t.references :profile, foreign_key: true
    end

    add_index :groups_profiles, [:group_id, :profile_id], unique: true
  end
end
