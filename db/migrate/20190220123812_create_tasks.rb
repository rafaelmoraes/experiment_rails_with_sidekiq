# frozen_string_literal: true

# Migration to create table tasks
class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :queue_name, default: :default
      t.datetime :done_at
      t.datetime :scheduled_at
      t.boolean :done, default: false
      t.boolean :canceled, default: false

      t.timestamps
    end
  end
end
