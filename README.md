# nosko-stojachkov_infra
nosko-stojachkov Infra repository

bastion_IP = 158.160.52.124
someinternalhost_IP = 10.128.0.17
testapp_IP = 158.160.54.193
testapp_port = 9292


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

Создание инстанса
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --core-fraction=20 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=14GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data=~/user-data.yaml \
  --metadata serial-port-enable=1
