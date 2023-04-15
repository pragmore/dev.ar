import express from 'express'
const app = express()

app.get('/', (_, res) => {
  res.setHeader('Content-Type', 'text/html')
  res.send('<body><h1>dev.ar</body>')
})

app.listen(process.env.PORT || 3000, () => {
  console.log('Iniciando app')
})
