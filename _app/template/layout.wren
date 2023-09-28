class Layout {
  static render(title, children) { "
<html lang='es'>
<head>
  <meta charset='UTF-8'/>
  <title>%( title )</title>
  <meta name='viewport' content='width=device-width, initial-scale=1' />
  <link rel='icon' href='data:image/svg+xml,%3Csvg%20xmlns=%22http://www.w3.org/2000/svg%22%20viewBox=%220%200%20100%20100%22%3E%3Ctext%20y=%22.9em%22%20font-size=%2290%22%3E👩‍💻%3C/text%3E%3C/svg%3E' />
  <link rel='stylesheet' href='https://cdn.pragmore.com/2.0.7/blouse.css?font=Poppins&family=sans-serif' />
  %( betaRibbon )
</head>
<body>
  <main class='text-center'>
    %( children )
  </main>
  %( footer )
</body>
</html>" }

  static betaRibbon { "body:after{content:"BETA";position:fixed;width:150px;height:30px;background:#9bc90d;top:12px;right:-48px;text-align:center;font-size:.8em;font-family:sans-serif;font-weight:700;color:#fff;line-height:35px;transform:rotate(45deg)}" }

  static footer { "<footer>
  <span><a href='/'><em>dev.ar</em></a></span>
  <span>Hecho con ❤️ por <a href='https://pragmore.com'>Pragmore</a></span>
  <span>
    <a href='https://twitter.com/pragmore' target='_blank' aria-label='GitHub'>
      <i class='tw' aria-hidden='true' title='Twitter'></i>
    </a>
  </span>
</footer>" }
}
