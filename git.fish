# git commit message
function gcm
  git commit -m $argv[1]
end

# git commit all message
function gcam
  git commit -am $argv
end

# git commit really all all message
function gcaam
  gaa
  git commit -m $argv
end

# Take a look at the latest commit, or the nth commit for some numeric argument n
function peek
  if count $argv > /dev/null
    git show HEAD~$argv[1]
  else
    git show HEAD
  end
end

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

# git push origin. If you're working something with a ./spec/ directory, it'll
# offer to run your specs for you
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

function gpf
  git push --force
end

# git log oneline
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

# git rebase interactive
function gri
  git rebase -i HEAD~$argv[1]
end

# Pull master, then rebase against it
function grm
  set curr_branch (git rev-parse --abbrev-ref HEAD)
  gcom
  gco $curr_branch
  git rebase master
end

# git clean - remove all merged branches
function gcl
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
end

function grc
  gaa ;and git rebase --continue
end

function gr
  git rebase $argv
end

function gs
  # Fuck me if I ever install GhostScript, amirite?
  git status
end

function gpu
  git pull $argv
end

# Get rid of any uncommitted changes, even if they're staged
function gnuke
  git stash
  git stash drop
end

# git add all
function gaa
  git add -A
end

# git add
function ga
  git add $argv
end

function gd
  git diff $argv
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

function gco
  git checkout $argv
end

# Checkout master and pull the latest version
function gcom
  git checkout master
  git pull
end

# git new branch
# Create a new branch against the latest master
function gnb
  gcom
  gco -b $argv
end

function gst
  git stash $argv
end

function gstp
  git stash pop
end

# Handy for when you're Douglas Crockford
# The worst commit ever: https://github.com/douglascrockford/JSON-js/commit/40f3377a631eaedeec877379f9cb338046cac0e0
function fk
  git commit -am 'for kyle'
end

# Handy for amending your latest commit onto the second-most recent one.
# Will start a rebase with your current work in a new commit with the message
# 'for kyle', which you can then easily squash onto the second-most recent commit
function glom
  fk; and gri 2
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
