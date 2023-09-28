import express from 'express'
import engine from 'express-engine-jsx'
import { db, Domain, User } from './db.js'

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
  const foundedDomain = await Domain.findOne({ where: { fqdn: req.hostname } })
  if (foundedDomain?.redirect) {
    res.redirect(foundedDomain.redirect)
  } else {
    next()
  }
})

app.use(express.urlencoded({ extended: false }))

app.get('/', (_, res) => {
  res.locals.title = 'dev.ar'
  res.render('index')
})

const renderSignUp = (req, res) => {
  res.locals.title = 'Registrate en dev.ar'
  const referrer = req.query.ref ?? ''
  res.render('signUp', {error: res.error, referrer})
}
app.get('/sign-up', renderSignUp)
app.post('/sign-up', async (req, res) => {
  try {
    const { email, fqdn, ref } = req.body
    console.log({email, referralId: ref || null})
    const user = await User.create({email, referralId: ref || null})
    const domain = await Domain.create({fqdn})
    await user.addDomain(domain)
    res.locals.title = `${fqdn} creado!`
    const url = `${req.protocol}://${req.hostname}`
    res.render('created', {user, domain, url})
  } catch (error) {
    res.error = error
    renderSignUp(req, res)
  }
})
app.get('/terms', (_, res) => {
  res.locals.title = 'Términos y Condiciones | dev.ar'
  res.render('terms')
})

app.listen(process.env.PORT || 3000, async () => {
  console.log('Iniciando app')
  await db.sync({ force: process.env.APP_ENV === 'dev'})
})
