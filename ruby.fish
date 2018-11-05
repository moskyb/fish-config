alias migrate 'rake db:migrate; and rake db:migrate RAILS_ENV=test'
alias cop 'be rubocop'
alias easy 'rake $argv[1]; and rake $argv[1] RAILS_ENV=test' # Do something in both development and test rails environtments
alias fs 'foreman start'
alias be 'bundle exec'
alias r 'rails'
alias rs 'bundle exec rails s'
alias rc 'dex (dis) bundle exec rails c'
alias cogem 'git checkout Gemfile Gemfile.lock' # Handy for when you're using specific gems locally that you don't want to push
alias rbs 'ruby scratch.rb'

# Run specs and rubocop in the same run. Can take a specific file as an arg
# I guess switching to a tab that's running a guard session is too much like hard work for me
function check
  if count $argv > /dev/null
    dex (dis) bundle exec rspec $argv[1]
    bundle exec rubocop $argv[1]
  else
    dex (dis) bundle exec rspec
    bundle exec rubocop
  end
end