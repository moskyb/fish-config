
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

function rbs
  ruby scratch.rb
end

function quit
	exit
end

function carny
	cd "/Users/moskyb/Carnival/carnival-"$argv"/"
  if test -e ./.env.sample
    if not test -e ./.env
      echo "Looks like you don't have a .env file. You should probably have one."
    end
  end
end

function rabbit
  docker run --rm -d --hostname my-rabbit  -p 15672:15672 -p 5672:5672  rabbitmq:3-management
  echo "RabbitMQ Started Successfully"
end
