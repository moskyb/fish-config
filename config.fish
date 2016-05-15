eval (thefuck --alias | tr '\n' ';')
set PATH $HOME/.rbenv/bin $PATH
set PATH "$HOME/.rbenv/shims" $PATH
rbenv rehash ^/dev/null
function rbenv
    set -l command $argv[1]
    if test (count $argv) -gt 1
        set argv $argv[2..-1]
    end

    switch "$command"
        case rehash shell
            eval (rbenv "sh-$command" $argv)
        case '*'
            command rbenv "$command" $argv
    end
end

function vcf
  vim ~/.config/fish/config.fish
end

function sagi
  sudo apt-get install -y $argv[1]
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

function ga
  git add $argv[1]
end

function gd
  git diff
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
      echo -n (git rev-parse --abbrev-ref HEAD)
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

