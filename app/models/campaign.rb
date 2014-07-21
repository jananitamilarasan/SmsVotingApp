	class Campaign < ActiveRecord::Base
  
  ####### Assocaitions #####
  has_many :campaign_choice_logs, dependent: :destroy
  has_many :choices, through: :campaign_choice_logs

  ###### Class Methods #######
=begin
The Below method is used to import the file
If the params of status is existing_doc,it will read the sample file 
If the params of status is new_doc,it will read the content from the uploaded files
And return the corresponding results to controller
=end
	def self.import_file(params)

		valid       = false
		if(params[:status]=="existing_doc")
			file      = File.readlines('votes_sample.txt')
			valid     = save_data(file)
		elsif(params[:status]=="new_doc")
			if params[:log_file] && params[:log_file].content_type=="text/plain"
				valid   = 	save_data(params[:log_file].read.sub( /\r\n/, "\n" ).split("\n"))
		  end
		end
		return valid
	end

	### Parsing and saving the data into db
	def self.save_data(file)
		valid          = false
			file.each do |u|
				#### The below one is used to form Hash
				record     =  Hash[u.gsub("VOTE ","VOTE:").strip.scan(/(\w+):(\w+)/).map { |(first, second)| [first.downcase.to_sym, second] }] rescue nil
			  #### Check the whether incoming keys are in same order
				if record.present? && (record.keys == CAMPAIGNS_KEYS)
					campaign = Campaign.find_or_initialize_by(:name=>record[:campaign],:short_code=> record[:shortcode])
					choice   = Choice.find_or_create_by(:name=>record[:choice])
				    campaign.campaign_choice_logs.build(record.as_json(
				  	            :except=>[:campaign,:shortcode,:choice]
				  	            ).merge(:choice_id => choice.id))
		           campaign.save
		           valid    = true
			 end
			end
			puts "Completed"
			return valid
	end

end
