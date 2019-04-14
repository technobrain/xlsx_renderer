# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :title,            null: false, limit: 20
      t.text :content,            limit: 255
      t.date :due_date,           null: false
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
