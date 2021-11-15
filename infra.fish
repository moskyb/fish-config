abbr dit 'docker exec -it'
abbr ddu 'doco up -d'
abbr dcd 'doco down'
abbr dr 'docker run'
abbr tf 'terraform'
abbr kc 'kubectl'
abbr kcf 'kubectl -n feed-tracking'
abbr av 'aws-vault'
abbr ave 'aws-vault exec'
abbr avl 'aws-vault login'

function klog
  kubectl get pods | grep $argv[1] | awk '{print $1}' | xargs -n 1 kubectl logs $argv[2..-1]
end

function tfe
  echo "> aws-vault exec $argv[1]-terraform -- ./tf.sh $argv"
  aws-vault exec "$argv[1]-terraform" -- "./tf.sh" $argv
end

function kcl
  if count $argv > /dev/null
    set -gx KUBECONFIG ~/.kube/config_$argv[1]
  end
  set kenv (kubectl config current-context | grep -oe '/.*' | sed 's|\/||')
  set kns (kubectl config view -o json | jq .contexts[0].context.namespace -r)
  set krole (rg -o "arn:aws:iam::.*:role/.*" $KUBECONFIG)
  echo -e "Currently working in the \e[34m$kenv\e[39m cluster, \e[32m$kns\e[39m namespace, \e[35m$krole\e[39m role"
end

function volrm
  docker volume ls | grep $argv[1] | awk '{print $2}' | xargs docker volume rm
end

function kgetalland
  kubectl get $argv[2] | grep $argv[3] | awk '{print $1}' | xargs kubectl $argv[1] $argv[2]
end

function kgetand
  kubectl get $argv[2] | grep $argv[3] | awk '{print $1}' | head -n 1 | xargs kubectl $argv[1] $argv[2]
end

function ksetns
  kubectl config set-context --current --namespace=$argv
end

function krole
  if ! count $KUBECONFIG > /dev/null
    echo "You don't have a \$KUBECONFIG set, try running kcl"
    return
  end
  if ! count $argv > /dev/null
    rg -oN --color never "arn:aws:iam::.*:role/.*" $KUBECONFIG
    return
  end
  set kenv (kubectl config current-context | grep -oe '/.*' | sed 's|\/||')
  set role "$kenv-kubernetes-$argv[1]-role"
  sed -E -i '' "s|(arn:aws:iam::.*:role\/).*|\1$role|g" $KUBECONFIG
  echo -e "Set role to \e[35m$role\e[39m"
end
