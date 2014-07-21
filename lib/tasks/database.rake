namespace :db do
  desc "Import Sample log file data into the application. "
  task :import => :environment do
  	Campaign.import_file({:status=>"existing_doc"})
  	puts "done"
  end
end