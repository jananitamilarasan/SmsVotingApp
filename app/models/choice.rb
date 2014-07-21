class Choice < ActiveRecord::Base
  has_many :campaign_choice_logs, dependent: :destroy
  has_many :campaigns, through: :campaign_choice_logs
end
