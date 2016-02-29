namespace :send_reports do
  # without environment it will just run plain ruby.

  desc "Send All Reports in the System"
  task :send_all => :environment do
    puts Cowsay.say("Sending Reports")
    SendAdminReportJob.perform_later
  end
end
 
