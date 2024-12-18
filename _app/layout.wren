import "_app/domain" for Usuario, Dominio

class Layout {
  static render(title, children) { <!doctype html>
  <html class="h-100" lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>{{ title }}</title>
        <!-- Favicon-->
        <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 00 100 100'><text y='.9em' font-size='90'>👩‍💻</text></svg>">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css">
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
        <!-- Seline Tracker -->
        <script async src="https://cdn.seline.so/seline.js"></script>
    </head>
    <body class="d-flex flex-column h-100">
        {{ bannerQuedan }}
        <!-- Navigation-->
        <nav class="navbar navbar-light bg-light static-top">
            <div class="container">
                <a class="navbar-brand" href="/">Tu espacio <strong>dev.ar</strong> gratis</a>
               {{ Usuario.estaLogueado ?
                    <a class="btn btn-secondary" href="/cerrar-sesion">Cerrar sesión</a> :
                    <a class="btn btn-secondary" href="/iniciar-sesion">Iniciar sesión</a>
               }}
            </div>
        </nav>
        {{ children }}
        <!-- Footer-->
        <footer class="footer bg-light mt-auto">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 h-100 text-center text-lg-start my-auto">
                        <ul class="list-inline mb-2">
                            <li class="list-inline-item"><a href="/">Buscar espacios</a></li>
                            <li class="list-inline-item">⋅</li>
                            <li class="list-inline-item"><a href="https://domains.pragmore.com" target="_blank"><strong>Dominios en venta</strong></a></li>
                            <li class="list-inline-item">⋅</li>
                            <li class="list-inline-item"><a href="/terminos-y-condiciones">Términos y Condiciones</a></li>
                            <li class="list-inline-item">⋅</li>
                            <li class="list-inline-item"><a href="https://github.com/pragmore/dev.ar/issues">Reportar problema</a></li>
                        </ul>
                        <p class="text-muted small mb-4 mb-lg-0">
                          Hecho en <a href="https://bialet.dev">Bialet</a> por <a href="https://pragmore.com">Pragmore</a>.
                          Theme por <a href="https://startbootstrap.com/theme/landing-page">Start Bootstrap</a>.
                        </p>
                    </div>
                    <div class="col-lg-6 h-100 text-center text-lg-end my-auto">
                        <ul class="list-inline mb-0">
                            <li class="list-inline-item me-4">
                                <a href="https://github.com/pragmore"><i class="bi-github fs-3"></i></a>
                            </li>
                            <li class="list-inline-item me-4">
                                <a href="https://twitter.com/pragmore"><i class="bi-twitter fs-3"></i></a>
                            </li>
                            <li class="list-inline-item">
                                <a href="https://www.linkedin.com/company/pragmore/"><i class="bi-linkedin fs-3"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col h-100 flex-grow-1 text-center fs-3">
                      <p class="mt-4">
                        Dev.AR (este sitio) y Pragmore SRL (quién lo administra) no tienen ninguna relación o vínculo con la DIRECCIÓN NACIONAL DEL REGISTRO DE DOMINIOS DE INTERNET (NIC Argentina), único organismo encargado del registro y administración del Dominio de Nivel Superior Argentina (.AR)
                      </p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html> }

  static headerBuscar(q) { <header class="masthead">
    <div class="container position-relative">
        <div class="row justify-content-center">
            <div class="col-xl-6">
                <div class="text-center text-white">
                    <!-- Page heading-->
                    <h1 class="mb-5">Busca tu espacio .dev.ar</h1>
                    <form class="form-subscribe" action="/buscar">
                        <!-- Email address input-->
                        <div class="row">
                            <div class="col">
                                <input class="form-control form-control-lg" name="q" id="q" type="text" placeholder="loquequieras.dev.ar" value="{{ q }}" data-sb-validations="required">
                            </div>
                            <div class="col-auto"><button class="btn btn-primary btn-lg" id="submitButton" type="submit">Buscar</button></div>
                        </div>
                        <!-- Submit success message-->
                        <!---->
                        <!-- This is what your users will see when the form-->
                        <!-- has successfully submitted-->
                        <div class="d-none" id="submitSuccessMessage">
                            <div class="text-center mb-3">
                                <div class="fw-bolder">Form submission successful!</div>
                                <p>To activate this form, sign up at</p>
                                <a class="text-white" href="https://startbootstrap.com/solution/contact-forms">https://startbootstrap.com/solution/contact-forms</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</header> }

  static bannerQuedan { Usuario.estaLogueado || (Dominio.quedan <= 0 || Dominio.quedan > 30) ? '' :
    <div class="banner sticky-top alert alert-warning text-center" role="alert">
      🔥 Quedan <strong>{{ Dominio.quedan }}</strong> espacios disponibles
    </div> }

}
