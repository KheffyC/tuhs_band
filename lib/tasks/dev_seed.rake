namespace :dev do
  desc 'Reset development DB and reseed (drop, create, migrate, seed)'
  task reset_and_seed: :environment do
    unless Rails.env.development?
      abort 'dev:reset_and_seed can only run in development environment.'
    end

    %w[db:drop db:create db:migrate db:seed].each do |task_name|
      puts "Running #{task_name}..."
      Rake::Task[task_name].reenable
      Rake::Task[task_name].invoke
    end

    puts 'Development database reset and seed complete.'
  end

  desc 'Alias for dev:reset_and_seed'
  task reseed: :reset_and_seed
end