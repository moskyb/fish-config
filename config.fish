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
  bundle exec rails s
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
  git push origin
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
	cd "/Users/bmosky/Carnival/carnival-"$argv"/"
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
