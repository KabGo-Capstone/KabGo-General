# ESDB Docker Compose

Docker Compose file for a secure three-node EventStoreDB cluster.

You need both `docker-compose.yml` and `vars.env` files.

## Cluster node addresses

All cluster nodes can be reached via TCP and HTTPS using `localhost` and the port value specified below:

| Node | TCP port | HTTP port |
| :--- | :------- | :-------- |
| node1 | 1111 | 2111 |
| node2 | 1112 | 2112 |
| node3 | 1113 | 2113 |

## Usage

```
docker-compose up
```
