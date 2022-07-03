class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      
      t.integer :follower_id # フォロー"する"  ユーザーの側
      t.integer :followed_id # フォロー"される"ユーザーの側

      t.timestamps
    end
  end
end
