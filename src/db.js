import { Sequelize, DataTypes } from 'sequelize'

// TODO: Configurar con el env
export const db = new Sequelize('sqlite::memory:', {define: {underscored: true}})
export const Domain = db.define('Domain', {
  fqdn: DataTypes.STRING,
  redirect: DataTypes.STRING,
})
