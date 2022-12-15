## Mise en pratique - Docker Application Express JS

### 1. Compléter le Dockerfile afin de builder correctement l’application contenu dans src/
### a. Une option de npm vous permet de n’installer que ce qui est nécessaire. Quelle est cette option ? Quelle bonne pratique Docker permet t-elle de respecter ?

https://docs.docker.com/language/nodejs/build-images/
https://www.geeksforgeeks.org/what-is-node_env-in-node-js/

- On utilise l'environnement de production pour node.
- Le fait d'installer npm avec le flag production nous permet de n'installer que les modules utiles. npm n'installera donc pas les modules devDependencies. 

```bash=
docker build --tag ma_super_app .

Sending build context to Docker daemon     64kB
Step 1/7 : FROM node:12-alpine3.9
 ---> a7d6e4c06dd4
Step 2/7 : WORKDIR /app
 ---> Running in e1a2ad015b74
Removing intermediate container e1a2ad015b74
 ---> 6b8b908f8efb
Step 3/7 : ENV NODE_ENV=production
 ---> Running in e547ea65c5e4
Removing intermediate container e547ea65c5e4
 ---> 1770ce47242f
Step 4/7 : COPY package.json .
 ---> fc1cda635272
Step 5/7 : COPY src/ ./src/
 ---> a0f2f1aef17c
Step 6/7 : RUN npm install --production     && npm audit fix --force
 ---> Running in 0212547cb2ae
Step 7/7 : CMD ["node", "src/index.js"]
 ---> Running in d80d69385a68
Removing intermediate container d80d69385a68
 ---> 93e1b290a970
Successfully built 93e1b290a970
Successfully tagged ma_super_app:latest
```

- Vérifier que l'image a bien été créée
```bash=
docker images
REPOSITORY                 TAG            IMAGE ID       CREATED          SIZE
ma_super_app               latest         93e1b290a970   39 seconds ago   136MB
```

- Vérifier que l'image fonctionne en lancant un conteneur avec l'image, voir docker logs
```bash=
docker run -d ma_super_app
39cf7a595d0fd6f9f5f38ff14958ef0d4f2792d1340e3fa91a2098ef3a7335f1

docker ps
CONTAINER ID   IMAGE                      COMMAND                  CREATED         STATUS        PORTS                                  NAMES
39cf7a595d0f   ma_super_app               "docker-entrypoint.s…"   2 seconds ago   Up 1 second                                          nifty_lalande

docker logs nifty_lalande
Running on port 3000
```


### 2. Compléter le fichier docker-compose.yml afin d’éxécuter ma_super_app avec sa base de données./!\ Utiliser correctement les variables d’environnement afin de configurer la base de données et l’application /!\

- Configurer le conteneur node_app et le conteneur mysqldb et lancer le docker compose up pour créer les conteneurs et les démarrer.
```bash=
docker compose up -d
[+] Running 3/3
 ⠿ Network docker-application-express-js_default  Created                                                                                                                      0.0s
 ⠿ Container mysqldb                              Started                                                                                                                      0.4s
 ⠿ Container node_app                             Started                                                                                                                      0.7s
```

- Vérifier que les conteneurs fonctionnent avec docker ps et docker logs
```bash=
docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                                                  NAMES
0dfda8418236   ma_super_app   "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp              node_app
007e6e159101   mysql:5.7      "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysqldb


docker logs -f node_app
Running on port 3000
```
- Tester en accédant à la page via http://IP:3000

![](https://i.imgur.com/g6NDMcL.png)



