JSON="{\"created\": \"$(date)\""

for APP in astral agreeable-egret api arithmancy big-poppa clio cream detention docker-listener drake eru github-varnish ingress-proxy khronos link mongo-navi navi-proxy navi optimus palantiri pheidi prometheus-alerts prmmetheus rabbitmq redis registry sauron swarm-manager runnable-angular enterprise-signin; do
  GIT_BRANCH=`util::get_latest_tag $APP 2>/dev/null`
  if [[ -n "$GIT_BRANCH" ]]; then
    APP_NAME=$(sed 's#-#_#g' <<< $APP)
    JSON="$JSON, \"${APP_NAME}_branch\": \"$GIT_BRANCH\""
  fi
done
JSON="$JSON}"
echo $JSON > ./versions.json
