function gcm
  git commit -m $argv[1]
end

function gcam
  git commit -am $argv
end

function peek
  if count $argv > /dev/null
    git show HEAD~$argv[1]
  else
    git show HEAD
  end
end

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
  # Fuck me if I ever install GhostScript, amirite?
  git status
end

function gpu
  git pull $argv
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
  if count $argv > /dev/null
    git branch $argv
  else
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:cyan)%(refname:short)%(color:reset) | %(committerdate:relative)%(color:reset) | %(subject)' | column -s '|' -t;
  end
end

function gco
  git checkout $argv
end

function gcom
  git checkout master
  git pull
end

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

function fk
  git commit -am 'for kyle'
end

function glom
  fk; and gri 2
end

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
