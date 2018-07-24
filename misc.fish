alias nvm 'bass source ~/.nvm/nvm.sh --no-use ";" nvm' # Use nvm because it by default doesn't work with fish
alias psf 'pgrep' # Find a running process
alias dit 'docker exec -it'
alias dr 'docker run'
alias db 'docker build'
alias sagi 'sudo apt-get install -y'
alias bi 'brew install'
alias bs 'brew services'
alias et 'e t --reporter dot'
alias bsl 'brew services list'
alias p 'python3' # Typing is hard ok
alias e 'nvm use 8.11.1 ;and ember' # Switch to node 8.11.1, which I use a lot, then do something ember-related
alias es 'e serve'
alias quit 'exit' # 'quit' is significantly easier to type than 'exit'. I am a very lazy person
alias gcat './gradlew clean connectedAndroidTest'
alias gt './gradlew clean test'
alias mdg 'mix deps.get'
alias renv 'cp .env.sample.sb .env'
alias sd 'serverless deploy'

function mkcd
  mkdir -p $argv[1]
  cd $argv[1]
end

# Kill all processes listening on the given port
function kp
  lsof -i ":$argv[1]" | grep LISTEN | awk '{print $2}' | xargs kill
end