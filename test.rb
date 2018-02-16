EDITOR=nano bin/rails secrets:edit


EDITOR=vi bin/rails credentials:edit

start: bundle exec sidekiq -q default -q mailers -C /app/config/sidekiq.rb  
