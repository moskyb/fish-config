# Adapted from https://github.com/JavaNut13/dotfiles/blob/master/fish/config.fish

#####################################################
# Startup stuff
#####################################################
status --is-interactive; and . (rbenv init -|psub)
eval (thefuck --alias | tr '\n' ';')
rbenv rehash ^/dev/null

#####################################################
# Diddling with this file
#####################################################
function vcf
  vim ~/.config/fish/config.fish
end

function cfp
  set curr_dir $PWD
  cd ~/.config/fish
  git commit -am $argv
  git push origin
  cd $curr_dir
end
  
#####################################################
# Ruby-related stuffs
#####################################################
function migrate
  rake db:migrate; and rake db:migrate RAILS_ENV=test
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
  rails s
end

function rc
  rails c
end

#####################################################
# Many and varied git shortcuts
#####################################################
function gcm
  git commit -m $argv[1]
end

function gcam
  git commit -am $argv
end

function gpo
  git push origin
end

function gpf
  git push --force
end

function glo
  git log --oneline
end

function grf
  git reflog
end

function gri
  git rebase -i $argv[1]
end

function grc
  git rebase --continue
end

function gr
  git rebase $argv
end

function gs
  git status
end

function gnuke
  git stash
  git stash drop
end

function gaa
  git add -A
end

function ga
  git add $argv
end

function gd
  git diff
end

function gco
  git checkout $argv
end

function gst
  git stash $argv
end

function gstp
  git stash pop
end

#####################################################
# Misc
#####################################################

function nvm
   bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
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
#######################################################

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
