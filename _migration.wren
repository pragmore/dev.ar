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
  UPDATE dominios SET fqdn = LOWER(fqdn);
`)

Db.migrate("Timestamps", `
  ALTER TABLE usuarios ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
  ALTER TABLE dominios ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
  UPDATE usuarios SET created_at = CURRENT_TIMESTAMP;
  UPDATE dominios SET created_at = CURRENT_TIMESTAMP;
  CREATE TRIGGER set_created_at_usuarios
  BEFORE INSERT ON usuarios
  FOR EACH ROW
  WHEN NEW.created_at IS NULL
  BEGIN
      UPDATE usuarios SET created_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
  END;
  CREATE TRIGGER set_created_at_dominios
  BEFORE INSERT ON dominios
  FOR EACH ROW
  WHEN NEW.created_at IS NULL
  BEGIN
      UPDATE dominios SET created_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
  END;
`)
