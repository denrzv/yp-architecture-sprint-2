# pymongo-api

## Схема проекта

![task drawio](https://github.com/user-attachments/assets/b2a83272-2893-4683-ace4-1009f7ffc68a)

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

Откройте в браузере [Test Endpoint](http://localhost:8080)

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
