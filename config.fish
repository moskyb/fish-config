# Startup stuff
set fish_greeting

source ~/.config/fish/fiddle.fish # Diddling with this file
source ~/.config/fish/ruby.fish # Ruby-related stuffs
source ~/.config/fish/git.fish # Many and varied git shortcuts
source ~/.config/fish/infra.fish # Docker, terraform, Kubernetes stuff
source ~/.config/fish/misc.fish # Misc
source ~/.config/fish/buildkite.fish # work stuff

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

function fish_title
  set -l command (echo $_)
  if test $command = "fish"
    # we are sitting at the fish prompt
    if git rev-parse --git-dir &> /dev/null
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

fish_add_path "$GOPATH/bin" $fish_user_paths
fish_add_path "$HOME/go/bin" $fish_user_paths
fish_add_path "$HOME/bin" $fish_user_paths
fish_add_path "$HOME/Library/Python/3.9/bin/" $fish_user_paths
fish_add_path "/opt/homebrew/bin" $fish_user_paths
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
kubectl completion fish | source
