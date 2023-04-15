import express from 'express'
import engine from 'express-engine-jsx'

const app = express()

app.set('view engine', 'jsx')
app.engine('jsx', engine)

app.get('/', (_, res) => {
  res.locals.title = 'dev.ar'
  res.render('index')
})

app.listen(process.env.PORT || 3000, () => {
  console.log('Iniciando app')
})
