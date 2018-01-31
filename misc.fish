alias nvm 'bass source ~/.nvm/nvm.sh --no-use ";" nvm $argv' # Use nvm because it by default doesn't work with fish
alias psf 'pgrep $argv' # Find a running process
alias dit 'docker exec -it $argv'
alias dr 'docker run $argv'
alias db 'docker build $argv'
alias sagi 'sudo apt-get install -y $argv[1]'
alias mkcd 'mkdir -p $argv[1] ;and cd $argv[1]'
alias bi 'brew install $argv[1]'
alias bs 'brew services $argv'
alias code 'code-insiders $argv'
alias et 'e t --reporter dot $argv'
alias bsl 'brew services list'
alias p 'python3 $argv' # Typing is hard ok
alias e 'nvm use 5.7.0 ;and ember $argv' # Switch to node 5.7.0, which I use a lot, then do something ember-related
alias es 'e serve'
alias quit 'exit' # 'quit' is significantly easier to type than 'exit'. I am a very lazy person
alias gcat './gradlew clean connectedAndroidTest'
alias gt './gradlew clean test'