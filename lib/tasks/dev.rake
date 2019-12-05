namespace :dev do
  desc 'Rebuild system'
  @build_tasks = Array.new
  @build_tasks << 'tmp:clear'
  @build_tasks << 'log:clear'
  @build_tasks << 'db:drop'
  @build_tasks << 'dev:clear_uploads'
  @build_tasks << 'db:create'
  @build_tasks << 'db:migrate'

  @rebuild_tasks = Array.new
  @rebuild_tasks << 'dev:build'
  @rebuild_tasks << "db:seed:#{Rails.env}"

  task :build => @build_tasks
  task :rebuild => @rebuild_tasks

  task :clear_uploads do
    FileUtils.rm_rf(Dir.glob("#{Rails.root}/storage"))
  end
end
