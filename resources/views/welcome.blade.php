<!doctype html>
<html lang="es">
<head>
  <title>dev.ar tu dominio gratis</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,%3Csvg%20xmlns=%22http://www.w3.org/2000/svg%22%20viewBox=%220%200%20100%20100%22%3E%3Ctext%20y=%22.9em%22%20font-size=%2290%22%3E👩‍💻%3C/text%3E%3C/svg%3E">
  <link rel="stylesheet" href="https://cdn.pragmore.com/2.0.5/solid/blouse.css?font=Poppins&family=sans-serif">
  <style>body:after{content:"BETA";position:fixed;width:150px;height:30px;background:#9bc90d;top:12px;right:-48px;text-align:center;font-size:.8em;font-family:sans-serif;font-weight:700;color:#fff;line-height:35px;transform:rotate(45deg)}</style>
</head>
<body>
  <main class="text-center">
    <h1>👩‍💻 <em>loquequieras</em>.dev.ar</h1>
    <p class="text-lg" id="text">
    ¿Queres tener tu dominio <strong>.dev.ar</strong> gratis?
    </p>
    <p class="text-lg">
      <a class="btn main" href="https://docs.google.com/forms/d/e/1FAIpQLSeG3nka7uzQALPTf0oQ6cWZw9dm1h0yMLZucVbbbhwdCFbWEQ/viewform?usp=sf_link">Sumate a la beta 🎉</a>
    </p>
  </main>
  <footer>
    <span>Hecho con ❤️ por <a href="https://pragmore.com">Pragmore</a></span>
    <span>
      <a href="https://twitter.com/pragmore" target="_blank" aria-label="GitHub">
        <i class="tw" aria-hidden="true" title="Twitter"></i>
      </a>
    </span>
  </footer>
  <script src="https://unpkg.com/typewriter-effect@2.3.1/dist/core.js"></script>
  <script>
    const wait = 1500;
    const container = document.querySelector('h1 em');
    const typewriter = new Typewriter(container, {
      loop: true
    });
    const match = window.location.search.match('from=([^&]+)');
    const texts = ['tunombre', 'mitienda', 'loquesea'];
    if (match) {
      texts.unshift(match[1])
    }
    for (text of texts) {
      typewriter.typeString(text)
        .pauseFor(wait)
        .deleteAll();
    }
    typewriter.start();
  </script>
</body>
</html>
