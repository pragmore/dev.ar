import "_app/domain" for Usuario

class Layout {
  static render(title, children) { '
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>%( title )</title>
        <!-- Favicon-->
        <link rel="icon" href="data:image/svg+xml,<svg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 00 100 100\'><text y=\'.9em\' font-size=\'90\'>👩‍💻</text></svg>" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-light bg-light static-top">
            <div class="container">
                <a class="navbar-brand" href="/">Dominios gratis</a>
                %( Usuario.estaLogueado ? 
                    '<a class="btn btn-primary" href="/cerrar-sesion">Cerrar sesión</a>':
                    '<a class="btn btn-primary" href="/iniciar-sesion">Iniciar sesión</a>'
                  )
            </div>
        </nav>
        %( children )
        <!-- Footer-->
        <footer class="footer bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 h-100 text-center text-lg-start my-auto">
                        <ul class="list-inline mb-2">
                            <li class="list-inline-item"><a href="/">Buscar dominio</a></li>
                            <li class="list-inline-item">⋅</li>
                            <li class="list-inline-item"><a href="https://pragmore.com">Nosotros</a></li>
                            <li class="list-inline-item">⋅</li>
                            <li class="list-inline-item"><a href="/terminos-y-condiciones">Términos y Condiciones</a></li>
                        </ul>
                        <p class="text-muted small mb-4 mb-lg-0">&copy; Pragmore SRL 2024. Todos los derechos reservados.</p>
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
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
  ' }

  static header(title) { '
    <header>
      <span><a href="/">👩‍💻 .dev.ar</a></span>
      <h1>%( title )</h1>
      %( Usuario.estaLogueado ? '<a href="/cerrar-sesion">Cerrar sesión</a>' : "" )
    </header>
  ' }

  static footer { '
    <footer>
      Hecho con ❤️ por <a href="https://pragmore.com">Pragmore</a>
    </footer>' }
}
