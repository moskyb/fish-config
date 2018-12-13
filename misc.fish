alias nvm 'bass source ~/.nvm/nvm.sh --no-use ";" nvm' # Use nvm because it by default doesn't work with fish
alias dlf 'docker logs -tf --tail 50'
alias dps 'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias e 'nvm use 8.11.1 ;and ember' # Switch to node 8.11.1, which I use a lot, then do something ember-related

abbr psf 'pgrep' # Find a running process
abbr dit 'docker exec -it'
abbr ddu 'doco up -d'
abbr dcd 'doco down'
abbr dr 'docker run'
abbr db 'docker build'
abbr mdg 'mix deps.get'
abbr mt 'mix test'
abbr mf 'mix format'
abbr ism 'iex -S mix'
abbr sagi 'sudo apt-get install -y'
abbr bi 'brew install'
abbr bs 'brew services'
abbr et 'e t --reporter dot'
abbr bsl 'brew services list'
abbr p 'python3' # Typing is hard ok
abbr es 'e serve'
abbr quit 'exit' # 'quit' is significantly easier to type than 'exit'. I am a very lazy person
abbr gcat './gradlew clean connectedAndroidTest'
abbr gt './gradlew clean test'
abbr mdg 'mix deps.get'
abbr renv 'cp .env.sandbox .env'
abbr sd 'serverless deploy'

function volrm
  docker volume ls | grep $argv[1] | awk '{print $2}' | xargs docker volume rm
end

function mkcd
  mkdir -p $argv[1]
  cd $argv[1]
end

# Kill all processes listening on the given port
function kp
  lsof -i ":$argv[1]" | grep LISTEN | awk '{print $2}' | xargs kill
end