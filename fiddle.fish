alias recon 'source ~/.config/fish/config.fish' # Reload config
abbr conf 'cd ~/.config/fish'

# Pull latest config from github
function cpull
  set curr_dir $PWD
  git pull
  cd ~/.config/fish
  cd $curr_dir
end

# Push latest config to github
function cfp
  set curr_dir $PWD
  cd ~/.config/fish
  git commit -am $argv
  git push origin
  cd $curr_dir
end
