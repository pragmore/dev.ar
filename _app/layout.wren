class Layout {
  static render(title, children) { "<html lang='es'>
  <head>
    <meta charset='UTF-8'/>
    <title>%( title )</title>
    <meta name='viewport' content='width=device-width, initial-scale=1' />
    <link rel='icon' href='data:image/svg+xml,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 00 100 100\"><text y=\".9em\" font-size=\"90\">👩‍💻</text></svg>' />
    <style>
      *, *:before, *:after { box-sizing: border-box }
      body{ background: #282a36; color: #f8f8f2; font: 1.3em system-ui; width:90\%; max-width: 30em; margin: 2em auto }
      h1, form{ text-align: center }
      a{ color: #ff79c6; text-decoration: none }
      input, button {
        padding:.5em;
        margin:.5em 0 0 0;
        border-color: #ccc;
        border-radius: 10px;
        box-shadow:0 0 15px 4px rgba(0,0,0,0.08);
        color: inherit;
        font: inherit;
        background: inherit;
        width: 100\%;
      }
      input[type='checkbox'] { width: auto }
      button { color: #282a36; background-color: #ffbbb8; cursor: pointer; border-style: none }
      footer { margin-top: 2em; text-align: center }

      h1 em { color: #bd93f9; font-style: normal }
      %( betaRibbon() )
    </style>
  </head>
  <body>
    <main class='text-center'>
      %( children )
    </main>
    %( footer() )
  </body>
  </html>" }

  static betaRibbon() { "body:after{content:\"BETA\";position:fixed;width:150px;height:30px;background:#9bc90d;top:12px;right:-48px;text-align:center;font-size:.8em;font-family:sans-serif;font-weight:700;color:#fff;line-height:35px;transform:rotate(45deg)}" }

  static footer() { "<footer>
    <span><a href='/'><em>dev.ar</em></a></span>
    <span>Hecho con ❤️ por <a href='https://pragmore.com'>Pragmore</a></span>
    <span>
      <a href='https://twitter.com/pragmore' target='_blank' aria-label='GitHub'>
        <i class='tw' aria-hidden='true' title='Twitter'></i>
      </a>
    </span>
  </footer>" }
}
