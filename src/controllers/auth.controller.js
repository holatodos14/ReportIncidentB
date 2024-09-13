import { pool } from '../config/db.js'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import { SECRET_KEY } from '../config/config.js'

export const login = async (req, res) => {
  console.log(req.body)
  try {
    const { email, password } = req.body

    const [rows] = await pool.query('SELECT * FROM User WHERE email = ?', [email])

    if (rows.length === 0) {
      return res.status(404).json({ message: 'User does not exist' })
    }

    const user = rows[0]

    const isValid = await bcrypt.compare(password, user.password)
    if (!isValid) {
      return res.status(400).json({ message: 'Invalid credentials' })
    }

    const token = jwt.sign({ id_user: user.id_user }, SECRET_KEY, { expiresIn: '1h' })
    console.log('Generated token:', token)

    const { password: _, ...userWithoutPassword } = user

    res.setHeader('Authorization', `Bearer ${token}`)

    res.json({ message: 'Login successful', token, user: userWithoutPassword })
  } catch (error) {
    console.error('Login error:', error.message)
    res.status(500).json({ message: 'Internal server error' })
  }
}

export const me = async (req, res) => {
  try {
    delete req.user.password
    res.json(req.user)
  } catch (error) {
    res.status(500).json({ message: error.message })
  }
}
