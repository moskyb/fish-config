
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

function psf
  ps aux | grep $argv
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

function bsl
  brew services list
end

function p
  python3 $argv
end

function e
  nvm use 5.7.0
  ember $argv
end

function es
  e serve
end

function quit
	exit
end

function rabbit
  docker run --rm -d --hostname my-rabbit  -p 15672:15672 -p 5672:5672  rabbitmq:3-management
  echo "RabbitMQ Started Successfully, maybe. Read something, you caveman"
end
