class CreatePosts < ActiveRecord::Migration[5.2]
    def change
        create_table :posts do |t|
            t.datetime :created_at
            t.datetime :updated_at
            t.string :image
            t.string :text
            t.string :tag_list
            t.integer :user_id
        end
    end
end
