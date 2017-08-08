function migrate
  rake db:migrate; and rake db:migrate RAILS_ENV=test
end

# Run specs and rubocop in the same run. Can take a specific file as an arg
# I guess switching to a tab that's running a guard session is too much like hard work for me
function check
  if count $argv > /dev/null
    bundle exec rspec $argv[1]
    bundle exec rubocop $argv[1]
  else
    bundle exec rspec
    bundle exec rubocop
  end
end

# Do something in both development and test rails environtments
function easy
  rake $argv[1]; and rake $argv[1] RAILS_ENV=test
end

function fs
  foreman start
end

function be
  bundle exec $argv
end

function r
  rails $argv
end

function rs
  bundle exec rails s $argv
end

function rc
  bundle exec rails c
end

# Handy for when you're using specific gems locally that you don't want to push
function cogem
  git checkout Gemfile Gemfile.lock
end

function rbs
  ruby scratch.rb
end
