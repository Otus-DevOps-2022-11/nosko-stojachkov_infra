# nosko-stojachkov_infra
nosko-stojachkov Infra repository

bastion_IP = 158.160.52.124
someinternalhost_IP = 10.128.0.17
testapp_IP = 158.160.55.29
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
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --core-fraction=20 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=14GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data=./user-data.yaml \
  --metadata serial-port-enable=1
```

### HW-7
Добавлен main.tf для создания инстанса с возможносью изменения количества через переменную instance_count.
Добавлен variables.tf в котором параметизированны переменные.
Добавлен вывод ip адресов через outputs.tf
Добавлен lb.tf в котором описан балансировщик с динамическим блоком без явного указания инстансов.

```
Инстанс #1: http://158.160.48.241:9292
Инстанс #2: http://51.250.83.166:9292
Адрес балансировщика: http://130.193.36.80:9292/
```

### HW-10
❯ ansible app -m command -a 'rm -rf ~/reddit'
[WARNING]: Consider using the file module with state=absent rather than running 'rm'.  If you need to use command because file is insufficient you can add 'warn: false' to
this command task or set 'command_warnings=False' in ansible.cfg to get rid of this message.
appserver | CHANGED | rc=0 >>

