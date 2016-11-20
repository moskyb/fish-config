# Adapted from https://github.com/JavaNut13/dotfiles/blob/master/fish/config.fish

status --is-interactive; and . (rbenv init -|psub)
eval (thefuck --alias | tr '\n' ';')
rbenv rehash ^/dev/null

function vcf
  vim ~/.config/fish/config.fish
end

function sagi
  sudo apt-get install -y $argv[1]
end

function bi
  brew install $argv[1]
end

function gs
  git status
end

function gitnuke
  git stash
  git stash drop
end

function gaa
  git add -A
end

function be
  bundle exec $argv[1]
end

function befs
  bundle exec foreman start
end

function p
  python3 $argv
end

function migrate
  rake db:migrate; and rake db:migrate RAILS_ENV=test
end

function easy
  rake $argv[1]; and rake $argv[1] RAILS_ENV=test
end

function ga
  git add $argv[1]
end

function gd
  git diff
end

function psf
  ps aux | grep $argv[1]
end

function fs
  foreman start
end

function gcam
  git commit -am $argv[1]
end

function gcm
  git commit -m $argv[1]
end

function gpo
  git push origin
end

function fish_prompt
  if [ $status = 0 ]
    set_color green
    if git rev-parse 2> /dev/null
      echo -n (git rev-parse --abbrev-ref HEAD 2> /dev/null)
    else
      echo -n "^_^"
    end
  else
    set_color red
    if git rev-parse 2> /dev/null
      echo -n (git rev-parse --abbrev-ref HEAD)
    else
      echo -n "x_x"
    end
  end
  set_color normal
  echo -n ' ('
  echo -n (prompt_pwd)
  echo -n ') '
end

function mkcd
  mkdir -p $argv[1]
  cd $argv[1]
end
