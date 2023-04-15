import Footer from './footer'
import BetaRibbon from './betaRibbon'

<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>{title}</title>
  <link rel="stylesheet" href="https://cdn.pragmore.com/2.0.6/blouse.css?font=Poppins&family=sans-serif" />
  <BetaRibbon />
</head>
<body>
  <main>
    {children}
  </main>
  <Footer />
</body>
</html>
