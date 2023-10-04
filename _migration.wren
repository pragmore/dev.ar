import "bialet" for Db

Db.migrate("Tabla usuarios", "
  CREATE TABLE usuarios (
    id INTEGER NOT NULL PRIMARY KEY,
    email TEXT,
    password TEXT,
    ref INTEGER
  )
")

Db.migrate("Tabla dominios", "
  CREATE TABLE dominios (
    id INTEGER NOT NULL PRIMARY KEY,
    usuario INTEGER NOT NULL,
    fqdn TEXT,
    redirect TEXT
  )
")
