# frozen_string_literal: true

class CreatePatientInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :public_id
      t.timestamps
    end

    create_table :patient_details do |t|
      t.belongs_to :patient_info
      t.string :detail
      t.timestamps
    end

    create_table :addresses do |t|
      t.belongs_to :patient_info
      t.string :address
    end

    create_table :health_records do |t|
      t.belongs_to :patient_info
      t.string :data
    end
  end
end
