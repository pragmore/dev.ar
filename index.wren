import "_app/layout" for Layout
import "_app/domain" for Usuario, Dominio

if (Usuario.estaLogueado) {
  return Response.redirect("/dashboard")
}

var html = Layout.render("Tu espacio .dev.ar gratis",
<main>
{{ Layout.headerBuscar('') }}
<!-- Icons Grid-->
<section class="features-icons bg-light text-center">
    <div class="container">
        <div class="row">
            <div class="col-lg-4">
                <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                    <div class="features-icons-icon d-flex"><i class="bi-gift m-auto text-primary"></i></div>
                    <h3>Gratis</h3>
                    <p class="lead mb-0">No hay que pagar nada, no necesitas poner tarjeta de crédito.</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                    <div class="features-icons-icon d-flex"><i class="bi-ui-checks m-auto text-primary"></i></div>
                    <h3>Fácil</h3>
                    <p class="lead mb-0">Crea una redirección o apuntalo al servidor que quieras.</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="features-icons-item mx-auto mb-0 mb-lg-3">
                    <div class="features-icons-icon d-flex"><i class="bi-person-check-fill m-auto text-primary"></i></div>
                    <h3>Uno solo</h3>
                    <p class="lead mb-0">No queremos que pocas personas tengan muchos.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Promo Mentoría -->
<section id="mentoria" class="bg-gradient-primary-to-secondary text-white py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 mx-auto text-center">
                <span class="badge bg-light text-primary mb-3">80% OFF - LANZAMIENTO</span>
                <h2 class="mb-3">Mentoría Tech con Albo</h2>
                <p class="lead mb-4">Mentoría personalizada para desarrolladores en crecimiento, seniors y Tech Leads. 20+ años de experiencia en la industria del software.</p>
                <div class="row text-start mb-4">
                    <div class="col-md-6 mb-3">
                        <h5><i class="bi-check-circle-fill me-2"></i>¿Para quién?</h5>
                        <ul class="small">
                            <li>Devs en crecimiento</li>
                            <li>Desarrolladores Senior</li>
                            <li>Tech Leads en formación</li>
                        </ul>
                    </div>
                    <div class="col-md-6 mb-3">
                        <h5><i class="bi-check-circle-fill me-2"></i>¿Qué incluye?</h5>
                        <ul class="small">
                            <li>Sesión 1:1 de 1 hora</li>
                            <li>Follow-up post sesión</li>
                            <li>Materiales personalizados</li>
                            <li>Consultas asincrónicas</li>
                        </ul>
                    </div>
                </div>
                <div class="mb-4">
                    <h4 class="mb-2">Precio de lanzamiento</h4>
                    <p class="fs-3 fw-bold mb-0">USD $20 / ARS $30.000 <span class="fs-6 text-decoration-line-through opacity-75">USD $100</span></p>
                </div>
                <a class="btn btn-light btn-lg" href="https://mentor.dev.ar" target="_blank">
                    <i class="bi-calendar-check me-2"></i>Reservar sesión
                </a>
            </div>
        </div>
    </div>
</section>
<!-- Image Showcases-->
<section class="showcase">
    <div class="container-fluid p-0">
        <div class="row g-0">
            <div class="col-lg-6 order-lg-2 text-white showcase-img" style="background-image: url('assets/img/bg-showcase-1.jpg')"></div>
            <div class="col-lg-6 order-lg-1 my-auto showcase-text">
                <h2>¿Cómo funciona?</h2>
                <p class="lead mb-0">Le brindamos un espacio bajo dev.ar, donde podras redirigir adonde quieras como un <a href="https://es.wikipedia.org/wiki/Acortador_de_URL">acortador de URL</a>. Además podrás configurar para que apunte a un servidor, si este lo soporta.</p>
            </div>
        </div>
        <div class="row g-0">
            <div class="col-lg-6 text-white showcase-img" style="background-image: url('assets/img/bg-showcase-3.jpg')"></div>
            <div class="col-lg-6 my-auto showcase-text">
                <h2>¿Por qué es gratis?</h2>
                <p class="lead mb-0">El proyecto no nos representa un costo elevado y creemos que todos tienen que tener un dominio propio. Si queres colaborar con nosotros podes seguirnos en nuestras redes y GitHub.</p>
            </div>
        </div>
    </div>
</section>
<!-- Testimonials-->
<section class="testimonials text-center bg-light">
    <div class="container">
        <h2 class="mb-5">Quienes estan usando nuestros espacios</h2>
        <div class="row">
            <div class="col-lg-4">
                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                    <img class="img-fluid rounded-circle mb-3" src="assets/img/testimonials-1.jpg" alt="..." />
                    <h5>Margaret E.</h5>
                    <p class="font-weight-light mb-0">"A la gilada ni cabida, yo la miro desde arriba"</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                    <img class="img-fluid rounded-circle mb-3" src="assets/img/testimonials-2.jpg" alt="..." />
                    <h5>No_Revolution9544</h5>
                    <p class="font-weight-light mb-0">"No lo tomes a mal, pero no me hace confiar mucho en vos, Rodrigo"</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                    <img class="img-fluid rounded-circle mb-3" src="assets/img/testimonials-3.jpg" alt="..." />
                    <h5>Sarah W.</h5>
                    <p class="font-weight-light mb-0">"Flaco no se quien sos, por favor salí de mi casa"</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Call to Action-->
<section class="call-to-action text-white text-center" id="signup">
    <div class="container position-relative">
        <div class="row justify-content-center">
            <div class="col-xl-6">
            </div>
        </div>
    </div>
</section>
</main>
)
Response.out(html)
