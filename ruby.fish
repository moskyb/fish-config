function migrate
  rake db:migrate; and rake db:migrate RAILS_ENV=test
end

function check
  if count $argv > /dev/null
    bundle exec rspec $argv[1]
    bundle exec rubocop $argv[1]
  else
    bundle exec rspec
    bundle exec rubocop
  end
end

function easy
  rake $argv[1]; and rake $argv[1] RAILS_ENV=test
end

function fs
  foreman start
end

function be
  bundle exec $argv
end

function befs
  bundle exec foreman start
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

function cogem
  git checkout Gemfile Gemfile.lock
end
