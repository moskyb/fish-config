# Use nvm because it by default doesn't work with fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# Find a running process
function psf
  pgrep $argv
end

function sagi
  sudo apt-get install -y $argv[1]
end

function mkcd
  mkdir -p $argv[1]
  cd $argv[1]
end

function bi
  brew install $argv[1]
end

function bs
  brew services $argv
end

function code
  code-insiders $argv
end

function et
  e t --reporter dot $argv
end

function bsl
  brew services list
end

# Typing is hard ok
function p
  python3 $argv
end

# Switch to node 5.7.0, which I use a lot, then do something ember-related
function e
  nvm use 5.7.0
  ember $argv
end

function es
  e serve
end

# 'quit' is significantly easier to type than 'exit'. I am a very lazy person
function quit
	exit
end

function gcat
  ./gradlew clean connectedAndroidTest
end

function gt
  ./gradlew clean test
end
