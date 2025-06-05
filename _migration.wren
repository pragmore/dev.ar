import "bialet" for Db

Db.migrate("Tabla usuarios", `
  CREATE TABLE usuarios (
    id INTEGER NOT NULL PRIMARY KEY,
    email TEXT,
    password TEXT,
    ref INTEGER
  )
`)

Db.migrate("Tabla dominios", `
  CREATE TABLE dominios (
    id INTEGER NOT NULL PRIMARY KEY,
    usuario INTEGER NOT NULL,
    fqdn TEXT,
    redirect TEXT
  )
`)

Db.migrate("Normalizar en minuscula", `
  UPDATE usuarios SET email = LOWER(email);
  UPDATE dominios SET fqdn = LOWER(fqdn)
`)

Db.migrate("Agregar created", `
  ALTER TABLE dominios ADD COLUMN created_at TIMESTAMP;
  ALTER TABLE usuarios ADD COLUMN created_at TIMESTAMP
`)

Db.migrate("Agregar DNS", `
  ALTER TABLE dominios ADD COLUMN dns TEXT
`)

Db.migrate("Agregar config de dominios gratis", `
  INSERT OR IGNORE INTO BIALET_CONFIG VALUES ("DOMINIOS_GRATIS", 1200)
`)

Db.migrate("Agregar tabla de palabras prohibidas", `
  CREATE TABLE palabras_prohibidas (
    id INTEGER NOT NULL PRIMARY KEY,
    palabra TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
`)

Db.migrate("Agregar palabras prohibidas iniciales", `
  INSERT INTO palabras_prohibidas (palabra) VALUES 
    ('banco'),
    ('santander'),
    ('galicia'),
    ('bbva'),
    ('icbc'),
    ('bank'),
    ('direct')
`)
