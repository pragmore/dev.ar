import { Sequelize, DataTypes } from 'sequelize'

// Conexión
const URI = `${process.env.DB_CONNECTION}://${process.env.DB_USERNAME}:${process.env.DB_PASSWORD}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`
export const db = new Sequelize(URI.replace(/:\/$/, ''), {
  define: {
    underscored: true,
    charset: 'utf8'
  }
})

// Modelos
const User = db.define('User', {
  email: {
    type: DataTypes.STRING,
    unique: true,
    validate: {
      isEmail: true
    }
  },
  referralId: {
    type: DataTypes.INTEGER,
    allowNull: true,
    references: {
      model: 'users',
      key: 'id'
    }
  },
})
User.belongsTo(User, { as: 'referrer', foreignKey: 'referralId' })
User.hasMany(User, { as: 'referrals', foreignKey: 'referralId' })

const Domain = db.define('Domain', {
  fqdn: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
    validate: {
      is: /^[a-z0-9-]{6,}\.dev\.ar$/i,
    }
  },
  redirect: {
    type: DataTypes.STRING,
    allowNull: true,
    validate: {
      isUrl: true
    }
  },
})
Domain.belongsTo(User)
User.hasMany(Domain)

export { User, Domain }
