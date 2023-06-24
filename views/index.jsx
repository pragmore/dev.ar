import Layout from './layout'
import Login from './login'

<Layout>
  <h1>👩‍💻 <em>loquequieras</em>.dev.ar</h1>
  <p class="text-lg" id="text">
  ¿Queres tener tu dominio <strong>.dev.ar</strong> gratis?
  </p>
  <p class="text-lg">
    <a class="btn main" href="/sign-up">Sumate a la beta 🎉</a>
  </p>
  <div class="mt-4">
    <Login error=""/>
  </div>

  <script src="https://unpkg.com/typewriter-effect@2.3.1/dist/core.js" />
  <script src="index.js" />
</Layout>
