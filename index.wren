import "bialet" for Response
import "_app/layout" for Layout
import "_app/domain" for Usuario, Dominio

if (Usuario.estaLogueado) {
  return Response.redirect("/dashboard")
}

var html = Layout.render("Dominios", '
%( Layout.headerBuscar('') )
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
                    <p class="lead mb-0">Redireccionalo a tu dominio o apuntalo al servidor que quieras</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="features-icons-item mx-auto mb-0 mb-lg-3">
                    <div class="features-icons-icon d-flex"><i class="bi-person-check-fill m-auto text-primary"></i></div>
                    <h3>Uno solo</h3>
                    <p class="lead mb-0">No queremos que pocas personas tengan muchos dominios</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Image Showcases-->
<section class="showcase">
    <div class="container-fluid p-0">
        <div class="row g-0">
            <div class="col-lg-6 order-lg-2 text-white showcase-img" style="background-image: url(\'assets/img/bg-showcase-1.jpg\')"></div>
            <div class="col-lg-6 order-lg-1 my-auto showcase-text">
                <h2>¿Cómo funciona?</h2>
                <p class="lead mb-0">Somos los dueños del dominio dev.ar, lo que hacemos es crear los subdominios para ustedes. Si esto quiere decir que no se puede usar con todos los proveedores pero si funciona con GitHub Pages, Vercel y muchos más.</p>
            </div>
        </div>
        <div class="row g-0">
            <div class="col-lg-6 text-white showcase-img" style="background-image: url(\'assets/img/bg-showcase-3.jpg\')"></div>
            <div class="col-lg-6 my-auto showcase-text">
                <h2>¿Por qué es gratis?</h2>
                <p class="lead mb-0">El mantenimiento del dominio y la app no nos representa un costo elevado y creemos que todos tienen que tener un dominio propio. Si queres colaborar con nosotros podes seguirnos en nuestras redes y GitHub.</p>
            </div>
        </div>
    </div>
</section>
<!-- Testimonials-->
<section class="testimonials text-center bg-light">
    <div class="container">
        <h2 class="mb-5">Quienes estan usando nuestros dominios</h2>
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
                    <h5>Fred S.</h5>
                    <p class="font-weight-light mb-0">"No de nuevo, decía."</p>
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
')
Response.out(html)
