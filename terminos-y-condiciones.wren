import "bialet" for Response
import "_app/layout" for Layout

var html = Layout.render("Terminos y condiciones de dev.ar", "
  <p>TÉRMINOS Y CONDICIONES DE SERVICIO PARA DEV.AR PROVISTO POR PRAGMORE S.R.L.</p>
  <ol>
    <li>
      <p>
    ACEPTACIÓN DE LOS TÉRMINOS Y CONDICIONES
      </p>
      <p>
Al registrar un subdominio a través de dev.ar, el usuario acepta en su totalidad estos Términos y Condiciones de Servicio. Si no está de acuerdo con estos términos, no utilice el servicio.
      </p>
    </li>
    <li>
      <p>
    USO LÍCITO DE LOS SERVICIOS
      </p>
      <p>
Los servicios contratados con Pragmore S.R.L. deben ser utilizados exclusivamente con fines lícitos. Cualquier contenido que se envíe o publique a través de los servicios de Pragmore S.R.L. debe ser coherente con estos términos y condiciones, así como con las reglamentaciones y/o leyes locales, nacionales e internacionales pertinentes.
      </p>
    </li>
    <li>
      <p>
    CONDUCTAS PROHIBIDAS
      </p>
      <p>
Mientras utilice los servicios contratados con Pragmore S.R.L., el usuario no podrá:
      </p>
      <ul>
        <li>Divulgar o transmitir información ilegal, abusiva, difamatoria, racista, ofensiva, o cualquier otro tipo de información susceptible de objeción, ya sea mediante fotografías, textos, banners publicitarios o enlaces a páginas externas.</li>
        <li>Publicar, transmitir, reproducir, distribuir o explotar cualquier información o software que contenga virus o cualquier otro componente dañino.</li>
        <li>Utilizar software u otro material que no sea original (pirateado), infringir derechos de propiedad intelectual, publicar o facilitar material o recursos sobre hacking, cracking.</li>
    </ul>
      <p>

Este punto incluye cualquier otra información que Pragmore S.R.L. considere inapropiada según su absoluto y exclusivo criterio. Cualquier uso indebido de los servicios autorizará a Pragmore S.R.L. a la suspensión o eliminación de los servicios contratados y sus contenidos sin previo aviso, no haciéndose responsable Pragmore S.R.L. por cualquier pérdida que esto implique.

      </p>
    </li>
    <li>
      <p>
    DENUNCIAS
      </p>
      <p>

        Para denunciar un servicio o subdominio que esté siendo utilizado para fines ilícitos, el canal de contacto es con nuestro Departamento de Investigación a través de: <a href='mailto:abuse@pragmore.com'>abuse@pragmore.com</a>. El accionar en las denuncias recibidas estará sujeto a la evaluación y criterio exclusivo de Pragmore S.R.L.

      </p>
    </li>
    <li>
      <p>
    DISPONIBILIDAD DEL SERVICIO Y PÉRDIDA DE DATOS
      </p>
      <p>

Pragmore S.R.L. realizará todos los esfuerzos técnicos al alcance para intentar que los servicios prestados estén disponibles 24x365. El usuario acepta que los servicios podrían no encontrarse disponibles en forma continua e ininterrumpida, por cualquier causa, y que Pragmore S.R.L. no asume responsabilidad alguna ante usted o ante terceros respecto de este punto.
      </p>
      <p>

Pragmore S.R.L. no se hace responsable por la pérdida de datos en el servidor causada por usuarios, fallos en el sistema, actualizaciones en nuestros servidores o cualquier otra causa. Es responsabilidad del usuario mantener una copia de seguridad (backup) de los contenidos almacenados en los espacios virtuales brindados como parte de la prestación de los servicios de Pragmore S.R.L.

      </p>
    </li>
    <li>
      <p>
        LEY APLICABLE Y JURISDICCIÓN
      </p>
      <p>

Estos Términos y Condiciones de Servicio se rigen por y se interpretan de acuerdo con las leyes de la República Argentina. Las partes se someten a la jurisdicción exclusiva de los tribunales de la República Argentina para resolver cualquier disputa que surja de estos Términos y Condiciones de Servicio.
      </p>
    </li>
  </ol>
  <p>Fecha de última actualización: <em>24 de junio de 2023</em>.</p>
")
Response.out(html)
