# AGENTS.md

## Visión General del Proyecto

**dev.ar** es un servicio gratuito que permite a desarrolladores registrar
subdominios bajo el dominio `.dev.ar`. Cada usuario puede reservar un único
subdominio y configurarlo para:

- **Redirección HTTP**: Redirigir a cualquier URL externa
- **DNS personalizado**: Apuntar el subdominio a un servidor propio (IP o
  dominio via CNAME)

El servicio está desarrollado con fines educativos y para promover la presencia
online de desarrolladores argentinos.

## Stack Tecnológico

- **Framework Web**: [Bialet](https://bialet.dev) (Wren + SQLite integrado)
- **Lenguaje**: [Wren](https://wren.io) - Lenguaje orientado a objetos tipo
  scripting
- **Base de datos**: SQLite3 (`_db.sqlite3`)
- **CSS Framework**: Bootstrap 5 + Bootstrap Icons + tema Landing Page
- **Integraciones**: Cloudflare API (para gestión de DNS), PostHog (analytics)

## Estructura de Directorios

```
_app/                   # Módulos protegidos de la aplicación
├── layout.wren         # Layout compartido (navbar, footer, head)
├── domain.wren         # Clases de dominio (Dominio, Usuario)
├── validator.wren      # Validaciones de email, password, DNS
└── cloudflare.wren     # Integración con API de Cloudflare

*.wren                  # Archivos de rutas (cada archivo = una ruta)
├── index.wren          # Página principal (/)
├── buscar.wren         # Búsqueda y registro de dominios (/buscar)
├── dashboard.wren      # Panel de configuración (/dashboard)
├── iniciar-sesion.wren # Login (/iniciar-sesion)
├── cerrar-sesion.wren  # Logout (/cerrar-sesion)
├── redirect.wren       # Endpoint de redirección (/redirect)
├── stats.wren          # Estadísticas API (/stats)
└── terminos-y-condiciones.wren # Términos legales

css/                    # Estilos CSS (tema Bootstrap personalizado)
js/                     # JavaScript (scripts del tema)
img/                    # Imágenes estáticas
assets/                 # Recursos adicionales (fotos, etc.)
admin/                  # Panel de administración (protegido)

_migration.wren         # Migraciones de base de datos
_db.sqlite3*            # Base de datos SQLite (ignorada en git)
```

## Convenciones de Código (Bialet)

### Estilo General

- **Indentación**: 2 espacios (no tabs)
- **Métodos de una línea**: Usar retorno implícito cuando sea posible

```wren
// CORRECTO - una línea con retorno implícito
static all() { `SELECT * FROM users`.fetch.to(User) }
save() { _id = Db.save("users", this) }
name { _name }

// EVITAR - múltiples líneas con return explícito para casos simples
static all() {
  return `SELECT * FROM users`.fetch.to(User)
}
```

### Estructura de Archivos de Ruta

Cada archivo `.wren` es una ruta. Estructura: lógica arriba, vista abajo.

```wren
// 1. Imports
import "_app/layout" for Layout
import "_app/domain" for Usuario

// 2. Lógica del controlador
if (!Usuario.estaLogueado) {
  return Response.redirect("/iniciar-sesion")
}

var mensaje
if (Request.isPost) {
  // Procesar formulario...
}

// 3. Vista (HTML renderizado)
var html = Layout.render("Título", <main>...</main>)
Response.out(html)
```

### Patrones de Autenticación

```wren
// Verificar login (redirigir si no está logueado)
if (!Usuario.estaLogueado) {
  return Response.redirect("/iniciar-sesion")
}

// Obtener dominio del usuario logueado
var dominios = Dominio.delUsuarioLogueado
```

### Consultas SQL

Usar siempre consultas parametrizadas con `?`:

```wren
// CORRECTO
var user = `SELECT * FROM users WHERE id = ?`.first(userId).to(User)
var count = `SELECT COUNT(*) FROM users`.toNum

// INCORRECTO - vulnerable a SQL injection
`SELECT * FROM users WHERE name = '%(name)'`.fetch
```

### Métodos de Query Disponibles

- `.query(params)` - Ejecutar consulta (devuelve last insert ID)
- `.fetch(params)` - Devuelve array de filas (List of Maps)
- `.first(params)` - Devuelve primera fila (Map) con LIMIT 1 automático
- `.val(params)` - Devuelve primer valor de primera fila
- `.toNum(params)` - Devuelve primer valor como número
- `.toBool(params)` - Devuelve primer valor como booleano
- `.to(Class)` - Mapea resultados a instancias de clase

### Mapeo a Clases de Dominio

```wren
// Múltiples resultados
var dominios = `SELECT * FROM dominios`.fetch.to(Dominio)

// Un solo resultado
var dominio = `SELECT * FROM dominios WHERE id = ?`.first(id).to(Dominio)
```

### Manejo de Sesiones

```wren
Session.new().set("usuario", idUsuario)    // Guardar en sesión
Session.new().get("usuario")               // Obtener de sesión
Session.destroy()                          // Cerrar sesión
```

## Rutas de la Aplicación

| Método | Ruta                         | Archivo                       | Descripción                      | Auth |
| ------ | ---------------------------- | ----------------------------- | -------------------------------- | ---- |
| GET    | `/`                          | `index.wren`                  | Página principal con landing     | No   |
| GET    | `/buscar?q=...`              | `buscar.wren`                 | Buscar disponibilidad de dominio | No   |
| POST   | `/buscar`                    | `buscar.wren`                 | Registrar nuevo dominio          | No   |
| GET    | `/dashboard`                 | `dashboard.wren`              | Panel de configuración           | Sí   |
| POST   | `/dashboard`                 | `dashboard.wren`              | Actualizar redirect/DNS          | Sí   |
| GET    | `/iniciar-sesion`            | `iniciar-sesion.wren`         | Formulario de login              | No   |
| POST   | `/iniciar-sesion`            | `iniciar-sesion.wren`         | Procesar login                   | No   |
| GET    | `/cerrar-sesion`             | `cerrar-sesion.wren`          | Cerrar sesión                    | Sí   |
| GET    | `/stats`                     | `stats.wren`                  | Estadísticas API (JSON)          | No   |
| GET    | `/redirect?fqdn=...&uri=...` | `redirect.wren`               | Endpoint de redirección          | No   |
| GET    | `/terminos-y-condiciones`    | `terminos-y-condiciones.wren` | Términos legales                 | No   |
| POST   | `/admin/reset`               | `admin/reset.wren`            | Resetear contraseña de usuario   | Admin |
| POST   | `/admin/abuse`               | `admin/abuse.wren`            | Deshabilitar dominio por abuse   | Admin |
| POST   | `/admin/txt`                 | `admin/txt.wren`              | Agregar registro TXT a dominio   | Admin |

## Clases de Dominio

### Dominio

```wren
Dominio.findByFqdn(fqdn)      // Buscar por nombre completo
Dominio.findByUsuario(userId) // Buscar dominios de un usuario
Dominio.delUsuarioLogueado    // Dominios del usuario actual
Dominio.guardar(dominio)      // Guardar/actualizar dominio
Dominio.total                 // Total de dominios registrados
Dominio.quedan                // Cupos disponibles (DOMINIOS_GRATIS - total)
Dominio.valido(dominio)       // Validar nombre de dominio
Dominio.normalizarDominio(d)  // Agregar .dev.ar si falta
Dominio.normalizarDns(dns)    // Limpiar protocolo http/s
```

### Usuario

```wren
Usuario.guardar(email, password, fqdn, ref)  // Crear usuario y dominio
Usuario.findByEmail(email)                   // Buscar por email
Usuario.iniciar(email, password)             // Login (devuelve id o false)
Usuario.estaLogueado                         // Boolean
Usuario.cerrarSesion                         // Destruir sesión
```

## Validaciones

### Reglas de Dominio

- Mínimo 6 caracteres (sin contar `.dev.ar`)
- Solo caracteres: `a-z`, `0-9`, `-`
- No puede contener palabras prohibidas (banco, santander, etc. - ver tabla
  `palabras_prohibidas`)
- Un usuario solo puede tener un dominio

### Configuración Mutuamente Exclusiva

- **Redirect** y **DNS** no pueden configurarse simultáneamente
- Para cambiar de uno a otro, primero se debe vaciar el campo actual

### DNS Válido

- Sin protocolos (`http://`, `https://`)
- Sin barras ni rutas (`/`)
- IP (registro A) o dominio (registro CNAME)

## Base de Datos

### Tablas Principales

| Tabla                 | Descripción                                           |
| --------------------- | ----------------------------------------------------- |
| `usuarios`            | Usuarios registrados (email, password hash)           |
| `dominios`            | Dominios reservados (fqdn, redirect, dns, usuario_id) |
| `palabras_prohibidas` | Lista de palabras no permitidas en dominios           |
| `BIALET_CONFIG`       | Configuración de la app (DOMINIOS_GRATIS)             |

### Migraciones

Las migraciones se definen en `_migration.wren` usando `Db.migrate()`:

```wren
Db.migrate("Nombre descriptivo", `
  CREATE TABLE tabla (...)
`)
```

## Configuración

La configuración se almacena en la tabla `BIALET_CONFIG`:

- `DOMINIOS_GRATIS`: Número máximo de dominios a registrar (default: 1200)

## Desarrollo Local

```bash
# Ejecutar servidor de desarrollo
bialet

# El servidor estará disponible en http://localhost:7000
```

## Convenciones de Git

- Mensajes en español, modo imperativo
- Descripciones cortas y claras
- Ejemplos: "Agregar reseteo de pass", "Agregar soporte para palabras prohibidas
  en dominios"

### .gitignore

```
_db.sqlite3*
```

> Nota: SQLite usa WAL mode, por lo que se generan múltiples archivos
> (`_db.sqlite3`, `_db.sqlite3-wal`, `_db.sqlite3-shm`)

## Integración con Cloudflare

La aplicación integra con la API de Cloudflare para:

- Crear registros DNS tipo A (para IPs)
- Crear registros DNS tipo CNAME (para dominios)
- Crear registros DNS tipo TXT (para verificación de dominio en Vercel, etc.)

### Métodos de Cloudflare

```wren
Cloudflare.actualizarDns(dominio)                    // Actualizar A/CNAME
Cloudflare.createTxtRecord(dominio, name, content)   // Crear registro TXT
```

Ver `_app/cloudflare.wren` para detalles de implementación.

## Notas Importantes

- El proyecto está en español (UI y contenido)
- El código fuente usa nombres en español para clases y métodos de dominio
- Se usa Bootstrap 5 con tema "Landing Page" de Start Bootstrap
- El favicon es un emoji 👩‍💻 (inline SVG)
- Analytics mediante PostHog

## Enlaces Relevantes

- [Bialet Framework](https://bialet.dev)
- [Wren Language](https://wren.io)
- [Repositorio GitHub](https://github.com/pragmore/dev.ar)
