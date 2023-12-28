# frozen_string_literal: true

class CreateCheckouts < ActiveRecord::Migration[7.1]
  def change
    create_table :checkouts do |t|
      t.string :customer_request_id, null: true
      t.string :grant_id, null: true
      t.integer :total

      t.timestamps
    end
  end
end
