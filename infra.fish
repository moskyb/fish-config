abbr dit 'docker exec -it'
abbr ddu 'doco up -d'
abbr dcd 'doco down'
abbr dr 'docker run'
abbr tf 'terraform'
abbr kc 'kubectl'
abbr kcf 'kubectl -n feed-tracking'

function klog
  kubectl -n feed-tracking get pods | grep $argv[1] | awk '{print $1}' | xargs kubectl -n feed-tracking logs $argv[2..-1]
end

function volrm
  docker volume ls | grep $argv[1] | awk '{print $2}' | xargs docker volume rm
end
