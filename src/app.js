import express from 'express'
import engine from 'express-engine-jsx'
import {db, Domain} from './db.js'

const START_WWW = /^www\./
const app = express()

app.set('view engine', 'jsx')
app.engine('jsx', engine)

app.use(async (req, res, next) => {
  if (req.hostname.match(START_WWW)) {
    const host = req.get('host').replace(START_WWW, '')
    const url = req.protocol + '://' + host + req.originalUrl
    return res.redirect(url)
  }
  const foundedDomain = await Domain.findOne({where: {fqdn: req.hostname}})
  if (foundedDomain?.redirect) {
    res.redirect(foundedDomain.redirect)
  } else {
    next()
  }
})

app.get('/', (_, res) => {
  res.locals.title = 'dev.ar'
  res.render('index')
})

app.listen(process.env.PORT || 3000, async () => {
  console.log('Iniciando app')
  await db.sync()
})
