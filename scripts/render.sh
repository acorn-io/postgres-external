#!/bin/sh

cat > /run/secrets/output<<EOF
services: postgres: {
  address: "${address}"
  default: true
  secrets: ["admin"]
  ports: "5432:${port}"
  data: {
    proto: "${proto}"
    dbName: "${dbName}"
  }
}

secrets: admin: {
  type: "basic"
  data: {
    username: "${adminUsername}"
    password: "${adminPassword}"
  }
}
EOF