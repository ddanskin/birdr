class CreateProfiles < ActiveRecord::Migration[5.2]
    def change
        create_table :profiles do |t|
            t.integer :user_id
            t.string :city
            t.string :state
            t.string :country
            t.string :about
            t.datetime :created_at
            t.datetime :updated_at
        end
    end
end
