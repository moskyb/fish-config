alias nvm 'bass source ~/.nvm/nvm.sh --no-use ";" nvm' # Use nvm because it by default doesn't work with fish
alias dlf 'docker logs -tf --tail 50'
alias dps 'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias e 'nvm use 8.11.1 ;and ember' # Switch to node 8.11.1, which I use a lot, then do something ember-related
alias ls exa
alias cat bat
alias fd fdfind

abbr psf 'pgrep' # Find a running process
abbr gw './gradlew'
abbr mdg 'mix deps.get'
abbr mt 'mix test'
abbr mf 'mix format'
abbr ism 'iex -S mix'
abbr es 'e serve'
abbr mdg 'mix deps.get'
abbr rmr 'rm -rf '
abbr renv 'cp .env.sandbox .env'

function mkcd
  mkdir -p $argv[1]
  cd $argv[1]
end

function bk
  cd ~/buildkite/$argv[1]
end

function bkbk
  bk buildkite
end

function codeat
  set curr_dir $PWD
  share $argv[1] && code .
  cd $curr_dir
end

# Kill all processes listening on the given port
function kp
  lsof -i ":$argv[1]" | grep LISTEN | awk '{print $2}' | xargs kill
end
