# v0.0.10

1. Create new exchange:
- Create ssh tunnel into Rabbit UI `ssh -NL 65322:localhost:65322 $YOUR_IP_ADDRESS`
- Login to UI
- Go to exchanges
- Create an durable, fanout exchange called `org.user.private-key.secured`

2. Make sure all your hosts are updated

3. Deploy docker-login.yml:

```
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json" docker-login.yml
```

4. Update Services:

```
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json"  -e git_branch=$(cat ../versions.json | jq '.api_branch') api.yml
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json"  -e git_branch=$(cat ../versions.json | jq '.runnable_angular_branch') web.yml
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json"  -e git_branch=$(cat ../versions.json | jq '.clio_branch') clio.yml
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json"  -e git_branch=$(cat ../versions.json | jq '.khronos_branch') khronos.yml
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json"  -e git_branch=$(cat ../versions.json | jq '.palantiri_branch') palantiri.yml
ansible-playbook -i main-hosts -e "@../main-vars.yml" -e "@../versions.json"  -e git_branch=$(cat ../versions.json | jq '.navi_branch') navi.yml
```
