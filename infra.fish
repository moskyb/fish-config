abbr dit 'docker exec -it'
abbr ddu 'doco up -d'
abbr dcd 'doco down'
abbr dr 'docker run'
abbr tf 'terraform'
abbr kc 'kubectl'
abbr kcf 'kubectl -n feed-tracking'

function klog
  kubectl -n feed-tracking get pods | grep $argv[1] | awk '{print $1}' | xargs -n 1 kubectl -n feed-tracking logs $argv[2..-1]
end

function kcl
  if count $argv > /dev/null
    set -gx KUBECONFIG ~/.kube/config_$argv[1]
    set arn (kubectl config current-context)
    echo -e "Set cluster to \e[34m$argv[1]\e[39m, ARN: \e[32m$arn"
  else
    set kenv (kubectl config current-context | grep -oe '\/.*' | sed 's|\/||')
    echo -e "Currently working in the \e[34m$kenv\e[39m cluster"
  end
end

function volrm
  docker volume ls | grep $argv[1] | awk '{print $2}' | xargs docker volume rm
end

function kgetand
  kubectl -n feed-tracking get $argv[2] | grep $argv[3] | awk '{print $1}' | head -n 1 | xargs kubectl -n feed-tracking $argv[1] $argv[2]
end
