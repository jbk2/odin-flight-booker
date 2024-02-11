namespace :sidekiq do
  desc "Clear all Sidekiq jobs and queues"
  task clear: :environment do
    Sidekiq::Queue.new.clear
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::DeadSet.new.clear
    puts "Sidekiq jobs and queues cleared"
  end
end
