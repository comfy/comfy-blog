# Small hack to auto-run migrations during testing
namespace :db do
  task :abort_if_pending_migrations => [:migrate]
end