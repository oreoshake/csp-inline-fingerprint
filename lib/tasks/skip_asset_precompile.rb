Rake::Task["assets:precompile"].clear

namespace :assets do
  task :precompile do
    puts "skipping asset compilation"
  end
end