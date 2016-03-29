class CreateEventStoreEvents < ActiveRecord::Migration[5.0]
  def change
    create_table(:event_store_events) do |t|
      t.string      :stream,      null: false
      t.string      :event_type,  null: false
      t.string      :event_id,    null: false
      t.jsonb       :metadata
      t.jsonb       :data,        null: false
      t.datetime    :created_at,  null: false
    end
    add_index :event_store_events, :stream
    add_index :event_store_events, :event_id, unique: true
  end
end
