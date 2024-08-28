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
exit()
EOF

sleep 5

###
# Инициализация шардов
###

docker compose exec -T shard1 mongosh --port 27020 --quiet <<EOF &
rs.initiate({
  _id: "shard1",
  members: [
    { _id: 0, host: "shard1:27020" }
  ]
})
exit()
EOF

docker compose exec -T shard2 mongosh --port 27021 --quiet <<EOF &
rs.initiate({
  _id: "shard2",
  members: [
    { _id: 0, host: "shard2:27021" }
  ]
})
exit()
EOF

wait

sleep 10

###
# Добавляем шарды в кластер и инициализируем БД
###

docker compose exec -T mongos_router mongosh --port 27022 --quiet <<EOF
sh.addShard("shard1/shard1:27020")
sh.addShard("shard2/shard2:27021")
sh.enableSharding("somedb")
sh.shardCollection("somedb.helloDoc", {"name" : "hashed"})
var bulk = db.helloDoc.initializeUnorderedBulkOp();
for(var i = 0; i < 1000; i++) {
  bulk.insert({age:i, name:"ly"+i});
}
bulk.execute();
db.helloDoc.countDocuments()
exit()
EOF