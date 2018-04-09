alias gcm 'git commit -m' # git commit message
alias gcam 'git commit -am' # git commit all message
alias gcaam 'gaa ;and git commit -m' # git commit really all all message
alias gpf 'git push --force'
alias gco 'git checkout'
alias grf 'git reflog'
alias gcl 'git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d' # git clean - remove all merged branches
alias gclcl 'git branch | egrep -v "(^\*|master|dev)" | xargs git branch -d' # git clean - remove all branches other than master, dev, and the one we're currently on
alias grc 'gaa ;and git rebase --continue'
alias gr 'git rebase'
alias gpu 'git pull'
alias gaa 'git add -A' # git add all
alias ga 'git add' # git add
alias gd 'git diff'
alias gst 'git stash'
alias gstp 'git stash pop'
alias peek 'git show HEAD~$argv' # Take a look at the latest commit, or the nth commit for some numeric argument n
alias gnuke 'git stash ;and git stash drop' # Get rid of any uncommitted changes, even if they're staged
alias gbb 'git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@"' # Git Base Branch - get default branch
alias gcom 'git checkout (gbb) ;and git pull' # Checkout master and pull the latest version
alias gnb 'gcom ;and gco -b' # git new branch
alias gs 'git status' # Fuck me if I ever install GhostScript, amirite?

# Handy for when you're Douglas Crockford
# The worst commit ever: https://github.com/douglascrockford/JSON-js/commit/40f3377a631eaedeec877379f9cb338046cac0e0
alias fk 'git commit -am "for kyle"'

# Handy for amending your current work onto the most recent commit.
# Will start a rebase with your current work in a new commit with the message
# 'for kyle', which you can then easily squash onto the second-most recent commit
alias glom 'fk; and gri 2'

# use cURL magic to get the PR for your current branch
# Requires that you set your github org, username and Personal Access Token as $gh_uname, $gh_org and $gh_pat respectively
function gpr
  echo "Just a sec..."
  set repo (basename (git rev-parse --show-toplevel))
  set branch (git rev-parse --abbrev-ref HEAD)
  curl -s -u "$gh_uname:$gh_pat" "https://api.github.com/repos/$gh_org/$repo/pulls" > tmp.json
  set link (cat tmp.json | jq -r ".[] | select(.head.ref | startswith(\"$branch\")).html_url")
  open $link
  rm tmp.json
end

function gri
  git rebase -i HEAD~$argv[1]
end

# git push origin. If you're working something with a ./spec/ directory, it'll offer to run your specs for you
function gpo
  if not test -d ./spec/
    git push origin
  else
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

# Used in the `gpo` command
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

# Used in the `gpo` command
function push_anyway
  echo 'Uh oh, looks like your specs failed, or you quit prematurely. Push anyway? [Y/N] '
end

# Used in the `gpo` command
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

# Used in the `gpo` command
function run_specs
  echo 'Run specs before pushing? [Y/N] '
end
