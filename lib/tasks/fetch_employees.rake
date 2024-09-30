namespace :employees do
  desc 'Fetch and store employees from API'
  task fetch: :environment do
    FetchEmployeesJob.perform_now
  end
end
