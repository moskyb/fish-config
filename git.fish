alias gcl 'git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d' # git clean - remove all merged branches
alias gclcl 'git branch | egrep -v "(^\*|master|dev)" | xargs git branch -D' # git really clean - remove all branches other than master, dev, and the one we're currently on
alias grc 'git add -A ;and git rebase --continue'
alias gnuke 'git stash ;and git stash drop' # Get rid of any uncommitted changes, even if they're staged
alias gco 'git checkout'
alias main-branch "git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'"
alias gcom 'git checkout master ;and git pull' # Checkout master and pull the latest version
alias gnb 'gcom ;and gco -b' # git new branch

abbr gcm 'git commit -m' # git commit message
abbr gcam 'git commit -am' # git commit all message
abbr gcom 'git checkout master ;and git pull' # Checkout master and pull the latest version
abbr gcaam 'gaa ;and git commit -m' # git commit really all all message
abbr gpf 'git push --force-with-lease'
abbr gco 'git checkout'
abbr grf 'git reflog'
abbr gr 'git rebase'
abbr gpu 'git pull'
abbr gaa 'git add -A' # git add all
abbr ga 'git add' # git add
abbr gd 'git diff'
abbr gst 'git stash'
abbr gstp 'git stash pop'
abbr gcap 'git commit --amend'
abbr squash 'git add -A ;and git commit --amend --no-edit'
abbr gs 'git status' # Fuck me if I ever install GhostScript, amirite?

# Handy for when you're Douglas Crockford
# The worst commit ever: https://github.com/douglascrockford/JSON-js/commit/40f3377a631eaedeec877379f9cb338046cac0e0
abbr fk 'git commit -am "for kyle"'

# Handy for amending your current work onto the most recent commit.
# Will start a rebase with your current work in a new commit with the message
# 'for kyle', which you can then easily squash onto the second-most recent commit
abbr glom 'git commit --amend'

function open-conflicts
  git status --porcelain | grep 'UU' | awk '{print $2}' | tr '\n' ' ' | xargs code
end

# Take a look at the latest commit, or the nth commit for some numeric argument n
function peek
  git show HEAD~$argv
end

function gri
  git rebase -i HEAD~$argv[1]
end

# git push origin. If you're working something with a ./spec/ directory, it'll offer to run your specs for you
function gpo
  if [ (git rev-parse --abbrev-ref HEAD) != "master" ]
    git push origin
  else
    echo "You're on the master branch, I'm guessing you don't want to push directly. If you do, type out 'git push origin'"
  end
end

# git log oneline
function glo
  if count $argv > /dev/null
    git log --oneline -n $argv[1]
  else
    git log --oneline -n 10
  end
end

# Pull master, then rebase against it
function grm
  set curr_branch (git rev-parse --abbrev-ref HEAD)
  gcom
  gco $curr_branch
  git rebase master
end


# With no args, show available branches in a nice and easy-to-read way - thanks @aupajo!
# With args, it's just git branch
function gb
  if count $argv > /dev/null
    git branch $argv
  else
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:cyan)%(refname:short)%(color:reset) | %(committerdate:relative)%(color:reset) | %(subject)' | column -s '|' -t;
  end
end
