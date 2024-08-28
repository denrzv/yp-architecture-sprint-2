# pymongo-api

## Схема проекта

![task drawio](https://github.com/user-attachments/assets/54a3c115-0078-4ae0-9ac9-2175864ea22e)


## Как запустить

Запускаем шардированный кластер mongodb и приложение

```shell
docker compose up -d
```

Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```

## Как проверить

### Консоль

При запуске скрипта будет выведено количество документов в БД:

```shell
[direct: mongos] test> 1000
[direct: mongos] test> 
```

### Если вы запускаете проект на локальной машине

Откройте в браузере <a href="http://localhost:8080" target="_blank">Test Endpoint</a>

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs

## Выключение

```shell
docker compose down -v
```
