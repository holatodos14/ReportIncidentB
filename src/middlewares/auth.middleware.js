import jwt from 'jsonwebtoken'
import { SECRET_KEY } from '../config/config.js'
import { pool } from '../config/db.js'

export const validateToken = async (req, res, next) => {
  try {
    const token = req.headers.authorization?.split(' ')[1]
    console.log('Received token:', token)

    if (!token) {
      console.error('Token not provided')
      return res.status(401).json({ message: 'Token not provided' })
    }

    const decoded = jwt.verify(token, SECRET_KEY)
    console.log('Decoded JWT:', decoded)

    const [rows] = await pool.query('SELECT * FROM User WHERE id_user = ?', [decoded.id_user])

    if (rows.length === 0) {
      console.error('User not found for id:', decoded.id_user)
      return res.status(404).json({ message: 'User not found' })
    }

    req.user = rows[0]
    next()
  } catch (error) {
    console.error('Error in validateToken:', error.message)
    if (error instanceof jwt.TokenExpiredError) {
      return res.status(401).json({ message: 'Token expired' })
    }
    res.status(500).json({ message: 'Internal server error', error: error.message })
  }
}
