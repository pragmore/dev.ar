import "bialet" for Response
import "_app/layout" for Layout

var html = Layout.render("Terminos y condiciones de dev.ar", '
<div class="container">
  <h2 class="m-4">TÉRMINOS Y CONDICIONES DE SERVICIO PARA DEV.AR PROVISTO POR PRAGMORE S.R.L.</h2>
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

        Para denunciar un servicio o subdominio que esté siendo utilizado para fines ilícitos, el canal de contacto es con nuestro Departamento de Investigación a través de: <a href="mailto:dev.ar@pragmore.com">dev.ar@pragmore.com</a>. El accionar en las denuncias recibidas estará sujeto a la evaluación y criterio exclusivo de Pragmore S.R.L.

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
       PROTECCIÓN DE DATOS PERSONALES
      </p>
      <p>
Pragmore S.R.L. se compromete a:
      </p>
      <p>
    Recoger solo los datos necesarios para la prestación del servicio y con el consentimiento explícito del usuario.
    Usar los datos personales únicamente para los fines especificados al momento de la recolección.
    Mantener la confidencialidad y seguridad de los datos personales, implementando medidas adecuadas para prevenir su alteración, pérdida, tratamiento o acceso no autorizado.
    Permitir a los usuarios el acceso a sus datos personales, así como su rectificación, supresión o cancelación cuando lo soliciten.
      </p>
    </li>
    <li>
      <p>
        CONSENTIMIENTO DEL USUARIO
      </p>
      <p>
        Al registrarse en dev.ar, el usuario otorga su consentimiento claro y explícito para el tratamiento de sus datos personales según los fines especificados.
      </p>
    </li>
    <li>
      <p>
        DERECHOS DE ACCESO, RECTIFICACIÓN, CANCELACIÓN Y OPOSICIÓN
      </p>
      <p>
        El usuario puede ejercer sus derechos de acceso, rectificación, cancelación y oposición de sus datos personales enviando una solicitud a <a href="mailto:dev.ar@pragmore.com">dev.ar@pragmore.com</a>.
      </p>
    </li>
    <li>
      <p>
        SEGURIDAD DE LOS DATOS
      </p>
      <p>
Pragmore S.R.L. adoptará las medidas técnicas y organizativas necesarias para garantizar la seguridad de los datos personales y evitar su alteración, pérdida, tratamiento o acceso no autorizado.
    <li>
      <p>
        LEY APLICABLE Y JURISDICCIÓN
      </p>
      <p>
Estos Términos y Condiciones de Servicio se rigen por y se interpretan de acuerdo con las leyes de la República Argentina. Las partes se someten a la jurisdicción exclusiva de los tribunales de la República Argentina para resolver cualquier disputa que surja de estos Términos y Condiciones de Servicio.
      </p>
    </li>
    <li>
      <p>
        LIMITACIÓN DE SUBDOMINIOS
      </p>
      <p>
        Cada usuario tiene derecho a registrar un único subdominio bajo dev.ar. Esta restricción busca garantizar la equidad y el acceso justo a los recursos disponibles.
      </p>
    </li>
    <li>
      <p>
        RESERVA DE DERECHOS POR PRAGMORE S.R.L.
      </p>
      <p>
        Pragmore S.R.L. se reserva el derecho de cancelar o suspender cualquier subdominio registrado bajo dev.ar en cualquier momento y sin necesidad de proporcionar una justificación. Esta medida podrá tomarse en caso de que Pragmore S.R.L. detecte incumplimientos de los presentes Términos y Condiciones, uso indebido del servicio o por cualquier otra razón que Pragmore S.R.L. considere pertinente. Los usuarios serán notificados de dicha cancelación o suspensión en la medida de lo posible.
  </ol>
  <p>Fecha de última actualización: <em>20 de marzo de 2024</em>.</p>
</div>
')
Response.out(html)
