import Layout from './layout'

<Layout>
  <h1>👩‍💻 {domain.fqdn}</h1>
  <p className='msg ok'>Tu usuario fue creado correctamente y tu dominio quedó reservado.</p>
  <p>En estos días vas a recibir un correo para la delegación.</p>
  <p>Podés compartir este link a tus amigos para tener mas dominios disponibles</p>
  <p><code>{ url }/sign-up?ref={ user.id }</code></p>
</Layout>
