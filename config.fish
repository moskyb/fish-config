# Loosely adapted from https://github.com/JavaNut13/dotfiles/blob/master/fish/config.fish

#####################################################
# Startup stuff
#####################################################
status --is-interactive; and . (rbenv init -|psub)
rbenv rehash ^/dev/null
set -x GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin


#####################################################
# Diddling with this file
#####################################################
function vcf
  vim ~/.config/fish/config.fish
end

function acf
  atom ~/.config/fish/config.fish
end

function cpull
  set curr_dir $PWD
  git pull
  cd ~/.config/fish
  cd $curr_dir
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

function check
  if count $argv > /dev/null
    bundle exec rspec $argv[1]
    bundle exec rubocop $argv[1]
  else
    bundle exec rspec
    bundle exec rubocop
  end
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
  bundle exec rails s $argv
end

function rc
  bundle exec rails c
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
  if read_confirm_run_specs
    check
    if test $status -eq 0
      git push origin
    else
      if confirm_push_anyway
        git push origin
      end
    end
  else
    git push origin
  end
end

function gpf
  git push --force
end

function glo
  if count $argv > /dev/null
    git log --oneline -n $argv[1]
  else
    git log --oneline -n 10
  end
end

function grf
  git reflog
end

function gri
  git rebase -i HEAD~$argv[1]
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

function gb
  git branch $argv
end

function gco
  git checkout $argv
end

function gcom
  git checkout master
  git pull
end

function gst
  git stash $argv
end

function gstp
  git stash pop
end

function fk
  git commit -am 'for kyle'
end

#####################################################
# Misc
#####################################################

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
#######################################################

function confirm_push_anyway
  while true
    read -l -p push_anyway confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function push_anyway
  echo 'Uh oh, looks like your specs failed, or you quit prematurely. Push anyway? [Y/N] '
end

function read_confirm_run_specs
  while true
    read -l -p run_specs confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function run_specs
  echo 'Run specs before pushing? [Y/N] '
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

# Change the terminal title automatically based on current process / working-directory
#
# The main improvement over the default 'fish_title' behavior
# is that I use the name of the current git repo, if any, as
# opposed to the raw working-directory
function fish_title
    set -l command (echo $_)

    if test $command = "fish"
        # we are sitting at the fish prompt

        if git rev-parse --git-dir > /dev/null ^ /dev/null
            # we are inside a git directory, so use the name of the repo as the terminal title

            set -l git_dir (git rev-parse --git-dir)
            if test $git_dir = ".git"
                # we are at the root of the git repo
                echo (basename (pwd))
            else
                # we are at least one level deep in the git repo
                echo (basename (dirname $git_dir))
            end
        else
            # we are NOT inside a git repo, so just use the working-directory
            echo (pwd)
        end
    else
        # we are busy running some non-fish command, so use the command name
        echo $command
    end
end
