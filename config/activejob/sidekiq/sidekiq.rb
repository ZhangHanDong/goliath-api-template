# startup sidekiq
#bundle exec sidekiq -vr ./config/sidekiq.rb -d -e development -L log/sidekiq.log

$: << "../../app" << "./app"
$: << "../../config" << "./config"

require 'application'
