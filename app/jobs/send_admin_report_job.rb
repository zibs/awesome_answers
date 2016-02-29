class SendAdminReportJob < ActiveJob::Base
  queue_as :default
# arguments will be an array
  def perform(*args)
    # Do something later
    puts "heyman"
  end
end
# SendAdminReportJob.perform_now
# SendAdminReportJob.perform_later

# ^^ will call perform internally
