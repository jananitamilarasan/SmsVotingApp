class CreateCampaignChoiceLogs < ActiveRecord::Migration
  def change
    create_table :campaign_choice_logs do |t|
      t.references :campaign
      t.references :choice
       t.integer :vote
    	t.string :validity
    	t.string :conn
    	t.string :msisdn
    	t.string :guid
      t.timestamps
    end
  end
end
