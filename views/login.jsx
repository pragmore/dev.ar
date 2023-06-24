<>
  <p>Ya tengo un usuario, quiero <strong>iniciar sesión</strong></p>
  <form method='post' action='login'>
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
    <p><button className='btn'>Iniciar sesión</button></p>
  </form>
</>
