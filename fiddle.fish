# Open config in vim
function vcf
  vim ~/.config/fish/config.fish
end

function conf
  cd ~/.config/fish
end

# Open config in atom
function acf
  atom ~/.config/fish
end 

# Reload config
function recon
  source ~/.config/fish/config.fish
end

# Open config in atom
function ccf
  code ~/.config/fish
end 

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
