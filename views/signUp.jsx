import Layout from './layout'

<Layout>
  <h1>👩‍💻 Registrate en <em>dev.ar</em></h1>
  <form method='post'>
    <input type='hidden' name='ref' id='ref' value={ referrer } />

    { error ? <p className='msg err'>{ error.message }</p> : '' }

    <p><label htmlFor='email'>Correo electrónico</label></p>
    <p>
      <input
        type='email'
        name='email'
        id='email'
        placeholder='email@ejemplo.com'
        required
      />
    </p>

    <p>
      <label htmlFor='fqdn'>Dominio</label>
      Debe tener por lo menos 6 letras, números o guión medio y tiene que empezar con una letra.
    </p>
    <p>
      <input
        name='fqdn'
        id='fqdn'
        placeholder='dominio.dev.ar'
        pattern='^[a-z0-9-]{6,}\.dev\.ar$'
        required
      />
    </p>

    <p><label><input type='checkbox' name='terms' required /> Acepto los <a href='/terms' target='_blank'>términos y condiciones</a></label></p>

    <p><button className='btn main'>Registrar cuenta y dominio</button></p>

    <p>Ya tengo un usuario, <a href='/'>iniciar sesión</a></p>
  </form>
</Layout>
