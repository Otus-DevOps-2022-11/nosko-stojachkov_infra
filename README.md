# nosko-stojachkov_infra
nosko-stojachkov Infra repository

bastion_IP = 158.160.52.124
someinternalhost_IP = 10.128.0.17


Подключение к в одну команду:
```
ssh -i ~/appuser -AJ appuser@158.160.52.124 appuser@10.128.0.17
```


Подключение через alias:
Добавить в ~/.ssh/config
```
## bastion
host bastion
user appuser
hostname 158.160.52.124
IdentityFile ~/.ssh/appuser

## someinternalhost
host someinternalhost
user appuser
hostname 10.128.0.17
proxyjump bastion
```
