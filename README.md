# KabGo

Welcome to KabGo, the revolutionary on-demand transportation platform that brings convenience and efficiency to your everyday commute. With KabGo, we're reshaping the way you travel, providing a seamless experience that's similar to Grab but with some unique features to enhance your journey.

---

# INSTRUCTIONS

> First, to build a project you need to install **nodejs v21** with **docker** and **docker compose**.

Let's started !!

---

## Local Installation with docker compose

### Generate protobuf and install with docker compose

> Make sure that you have already in root folder

**Step 1: Change directory to server directory**

```shell
cd server
```

**Step 2: Install package and generate protobuf**

Window / MacOS / Linux:

```bash
npm ci
npm run proto:generate
```

**Step 3: Install all packages and dependencies of each sevice**

```shell
cd <service-directory>
npm ci
```

> Service directory: **"servers/admin"**, **"servers/supply"**, **"servers/demand"**, **"clients/admin"**

**Step 4: Change directory to docker-compose directory**

> Make sure that you have already in root folder

```shell
cd docker-compose
```

**Step 5: Run build the docker compose** (Optional: Only for first time installation)

Window:

```bash
docker compose up --build
```

Linux / MacOS:

```shell
sudo docker compose up --build
```

Alternative Linux / MacOS:

```shell
sudo docker-compose up --build
```

**Step 6: Run docker compose** (Skipped if you have already run step 5)

Window:

```bash
docker compose up
```

Linux / MacOS:

```shell
sudo docker compose up
```

Alternative Linux / MacOS:

```shell
sudo docker-compose up
```

> **Congrats, That all !! Now you can use the link below to access each service**

---

## Local Installation with docker compose

### Generate protobuf and install without docker compose

> Make sure that you have already in root folder

**Step 1: Change directory to server directory**

```shell
cd server
```

**Step 2: Install package and generate protobuf**

Window / MacOS / Linux:

```bash
npm ci
npm run proto:generate
```

**Step 3: Install all packages and dependencies of each sevice**

```shell
cd <service-directory>
npm ci
```

> Service directory: **"servers/admin"**, **"servers/supply"**, **"servers/demand"**, **"clients/admin"**

**Step 4: Start each sevice**

```shell
cd <service-directory>
npm run <start-command>
```

> Service directory: **"servers/admin"**, **"servers/supply"**, **"servers/demand"**, **"clients/admin"**

> Start command: **"start:dev"** for each server or **"start"** for each client

##

> **Congrats, That all !! Now you can use the link below to access each service**

---

## Links

### Services (Backend)

> -   Demand Service: [http://localhost:3001/status](http://localhost:3001/status)
> -   Supply Service: [http://localhost:3002/status](http://localhost:3002/status)
> -   Admin Service: [http://localhost:3003/status](http://localhost:3003/status)

### Clients (Frontend)

> -   Admin Client: [http://localhost:5003](http://localhost:5003)

---

## Deployment Links

### Services (Backend)

> -   Demand Service: [https://demand.kabgo.mtech.id.vn](https://demand.kabgo.mtech.id.vn)
> -   Supply Service: [https://supply.kabgo.mtech.id.vn](https://supply.kabgo.mtech.id.vn)
> -   Admin Service: [https://admin.kabgo.mtech.id.vn](https://admin.kabgo.mtech.id.vn)

### Clients (Frontend)

> -   Admin Client: [https://admin-panel.kabgo.mtech.id.vn](https://admin-panel.kabgo.mtech.id.vn)

---

## Clean Up Project (If you dont use anymore)

> Make sure that you have already in root folder

**Step 1: Change directory to docker-compose directory**

```shell
cd docker-compose
```

**Step 2: Run clean up the docker compose if you don't use anymore**

Window:

```bash
docker system prune -a
```

Linux / MacOS:

```shell
sudo docker system prune -a
```
