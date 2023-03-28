# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.belongs_to :folder, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
