import { Sequelize, DataTypes } from 'sequelize'

const URI = `${process.env.DB_CONNECTION}://${process.env.DB_USERNAME}:${process.env.DB_PASSWORD}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`
export const db = new Sequelize(URI.replace(/:\/$/, ''), {define: {
  underscored: true,
  charset: 'utf8',
}})
export const Domain = db.define('Domain', {
  fqdn: DataTypes.STRING,
  redirect: DataTypes.STRING,
})
