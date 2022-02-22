abbr cop 'bundle exec rubocop'
abbr copa 'bundle exec rubocop -a'
abbr be 'bundle exec'
abbr r 'rails'
abbr rs 'bundle exec rails s'
abbr cogem 'git checkout Gemfile Gemfile.lock' # Handy for when you're using specific gems locally that you don't want to push
abbr rbs 'ruby scratch.rb'

status --is-interactive; and rbenv init - fish | source

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
