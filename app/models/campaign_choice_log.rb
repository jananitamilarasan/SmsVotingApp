class CampaignChoiceLog < ActiveRecord::Base
	###### Association ####
	belongs_to :campaign
	belongs_to :choice
	##### Check the valid canditate score #####
  scope :scores, ->(ids) { where("validity like ?  and choice_id is NOT NULL and id in (?)",'during',ids)}
  #### Check for invalid score #####
  scope :invalid_scores, ->(ids) { where("validity in (?)   and id in (?)",["pre","post"],ids)}

end
