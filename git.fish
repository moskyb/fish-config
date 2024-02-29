alias gcl 'git branch --merged | egrep -v "(^\*|main)" | xargs git branch -d' # git clean - remove all merged branches
alias gclcl 'git branch | egrep -v "(^\*|main)" | xargs git branch -D' # git really clean - remove all branches other than main, dev, and the one we're currently on
alias gnuke 'git stash ;and git stash drop' # Get rid of any uncommitted changes, even if they're staged
alias gco 'git switch'
alias main-branch "git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'"
alias gcom 'git switch main ;and git pull' # Switch main and pull the latest version
alias gnb 'gcom ;and git switch -c' # git new branch

abbr grc 'git rebase --continue'
abbr gra 'git rebase --abort'
abbr gcm 'git commit -m' # git commit message
abbr gcam 'git commit -am' # git commit all message
abbr gcom 'git switch main ;and git pull' # Switch main and pull the latest version
abbr gcaam 'gaa ;and git commit -m' # git commit really all all message
abbr gpf 'git push --force-with-lease'
abbr gco 'git switch'
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

function checkout-fork
  argparse 'h/help' 'r/repo=' 'a/account=' 'b/branch=' -- $argv

  # if test -n $_flag_help
  #   echo "Usage: checkout-fork --account <fork account> [args]"
  #   echo
  #   echo "Checks out a fork of the repo you're currently in, adding a remote, and checking out the branch of the fork"
  #   echo
  #   echo "Options:"
  #   echo "  -h/--help: Show this help text"
  #   echo "  -a/--account: Set the account name of the fork. This must be set"
  #   echo "  -r/--repo: Set the repository name of the fork. Defaults to the name of repository this command is called from"
  #   echo "  -b/--branch: Set the branch name of the fork. Defaults to 'main'"
  #   return 0
  # end

  set repo (basename (git rev-parse --show-toplevel))
  if test -n $_flag_repo
    set repo $_flag_repo
  end

  if test -z $_flag_account
    echo "Account flag is mandatory, use either --account or -a"
    return 1
  end
  set fork_account $_flag_account

  set fork_branch "main"
  if test -n $_flag_branch
    set fork_branch $_flag_branch
  end

  set fish_trace 1
  git remote add $fork_account git@github.com:$fork_account/$repo.git; or return
  git fetch $fork_account; or return
  git checkout --track $fork_account/$fork_branch "$fork_account-$fork_branch"; or return
  set fish_trace 0
end

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
  if [ (git rev-parse --abbrev-ref HEAD) != "main" ]
    git push origin
  else
    echo "You're on the main branch, I'm guessing you don't want to push directly. If you do, type out 'git push origin'"
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

# Pull main, then rebase against it
function grm
  set curr_branch (git rev-parse --abbrev-ref HEAD)
  gcom
  gco $curr_branch
  git rebase main
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
