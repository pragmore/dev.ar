import Footer from './footer'
import BetaRibbon from './betaRibbon'

<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>{title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="icon" href="data:image/svg+xml,%3Csvg%20xmlns=%22http://www.w3.org/2000/svg%22%20viewBox=%220%200%20100%20100%22%3E%3Ctext%20y=%22.9em%22%20font-size=%2290%22%3E👩‍💻%3C/text%3E%3C/svg%3E" />
  <link rel="stylesheet" href="https://cdn.pragmore.com/2.0.7/blouse.css?font=Poppins&family=sans-serif&size=13pt" />
  <BetaRibbon />
</head>
<body>
  <main class="text-center">
    {children}
  </main>
  <Footer />
</body>
</html>
