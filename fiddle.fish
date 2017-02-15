function vcf
  vim ~/.config/fish/config.fish
end

function acf
  atom ~/.config/fish/config.fish
end

function cpull
  set curr_dir $PWD
  git pull
  cd ~/.config/fish
  cd $curr_dir
end

function cfp
  set curr_dir $PWD
  cd ~/.config/fish
  git commit -am $argv
  git push origin
  cd $curr_dir
end
