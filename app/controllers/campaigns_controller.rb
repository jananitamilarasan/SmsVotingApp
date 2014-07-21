class CampaignsController < ApplicationController

  ######### Listing all the campaigns #########
	def index
		@campaigns          = Campaign.paginate(:page => params[:page], :per_page => 10)
	end

=begin 
If campaigns are not found,user can option to import their log files
Parsing the file and saving in the db using import_file class method
=end
	def create
		status               = Campaign.import_file(campaign_params)
		if status
			flash[:notice]      = "Imported successfully!"
			redirect_to campaigns_path
		else
			flash[:error]      = "Please provide valid input!"
		 	render :index
		end
	end

##### The below method is used to display the scores for the particular campaig
	def show
		campaign              = Campaign.find_by_id(params[:id])
		@campaign_choice_logs = campaign.campaign_choice_logs rescue []
		redirect_to campaigns_path,:flash => { :error => "No Record found" } if campaign.nil? || @campaign_choice_logs.empty?
	end
	private
    def campaign_params
      # It's mandatory to specify the nested attributes that should be whitelisted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.permit(:status,:log_file,:id)
    end
end
