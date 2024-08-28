# pymongo-api

## Схема проекта

![task drawio](https://github.com/user-attachments/assets/748d507a-3baf-4663-b2f8-0d5681acc3b7)

## Как запустить

Запускаем шардированный кластер mongodb, redis и приложение

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

Для проверки скорости выполнения запроса получения списка пользователей (проверка эффекта redis):

```shell
curl -o /dev/null -s -w "Total time: %{time_total}s\n" http://localhost:8080/helloDoc/users
```

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
