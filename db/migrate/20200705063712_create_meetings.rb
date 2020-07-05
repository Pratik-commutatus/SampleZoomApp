class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :username
      t.string :user_email
      t.string :meeting_id
      t.string :meeting_password

      t.timestamps
    end
  end
end
