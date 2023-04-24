dev.ar
======

App para manejar los subdominios de **.dev.ar**.

Si queres tener un subdominio gratuito [create un usuario en la web](https://dev.ar).

Hecha con Express, con un template similar a React server side 
y con MySQL o SQLite como motor de base de datos.

Para ejecutarla en local correr:

```
npm install
npm run dev
```

Para ejecutarla en prod (necesita [pm2](https://pm2.keymetrics.io)):

```
npm ci --omit=dev
pm2 start src/app.js --watch --ignore-watch node_modules \
    --name dev.ar --node-args="-r dotenv/config"
```
