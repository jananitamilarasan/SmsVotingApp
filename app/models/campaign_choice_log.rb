class CampaignChoiceLog < ActiveRecord::Base
	###### Association ####
	belongs_to :campaign
	belongs_to :choice
	##### Check the valid canditate score #####
  # scope :scores, ->(ids) { where("validity like ?  && choice_id is NOT NULL && id in (?)",'during',ids)}
  #### Check for invalid score #####
  scope :invalid_scores, ->(ids) { where("validity in (?)   && id in (?)",["pre","post"],ids)}
def self.scores(ids)
	where("id in (?) && validity like ?  && choice_id is NOT NULL",ids,'during')
end
end
