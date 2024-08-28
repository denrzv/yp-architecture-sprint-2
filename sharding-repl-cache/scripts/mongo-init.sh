#!/bin/bash


###
# Инициализация конфигурационных серверов
###

docker compose exec -T configSrv1 mongosh --port 27017 --quiet <<EOF
rs.initiate({
  _id: "configReplSet",
  configsvr: true,
  members: [
    { _id: 0, host: "configSrv1:27017" },
    { _id: 1, host: "configSrv2:27018" },
    { _id: 2, host: "configSrv3:27019" }
  ]
})
EOF

sleep 5

###
# Инициализация шардов
###

docker compose exec -T shard1_1 mongosh --port 27020 --quiet <<EOF &
rs.initiate({
  _id: "shard1",
  members: [
    { _id: 0, host: "shard1_1:27020" },
    { _id: 1, host: "shard1_2:27120" },
    { _id: 2, host: "shard1_3:27220" }
  ]
})
EOF

docker compose exec -T shard2_1 mongosh --port 27021 --quiet <<EOF &
rs.initiate({
  _id: "shard2",
  members: [
    { _id: 0, host: "shard2_1:27021" },
    { _id: 1, host: "shard2_2:27121" },
    { _id: 2, host: "shard2_3:27221" }
  ]
})
EOF

wait

sleep 10

###
# Добавляем шарды в кластер и инициализируем БД
###

docker compose exec -T mongos_router1 mongosh --port 27022 --quiet <<EOF
sh.addShard("shard1/shard1_1:27020")
sh.addShard("shard2/shard2_1:27021")
sh.enableSharding("somedb")
sh.shardCollection("somedb.helloDoc", {"name" : "hashed"})
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
db.helloDoc.countDocuments()
EOF

docker-compose exec -T mongos_router2 mongosh --port 27023  --quiet <<EOF
db.adminCommand({ getShardMap: 1 })
EOF