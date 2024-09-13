import { pool } from '../config/db.js'

export const getAllUsers = async () => {
  const [rows] = await pool.query('SELECT * FROM User')
  return rows
}

export const getUserById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM User WHERE user_id = ?', [id])
  return rows[0]
}

export const createUser = async (user) => {
  const { firstName, lastName, email, password, userType } = user
  const [result] = await pool.query(
    'INSERT INTO User (first_name, last_name, email, password, user_type) VALUES (?, ?, ?, ?, ?)',
    [firstName, lastName, email, password, userType]
  )
  return { id: result.insertId, ...user }
}

export const updateUser = async (id, user) => {
  const { firstName, lastName, email, password, userType } = user
  await pool.query(
    'UPDATE User SET first_name = ?, last_name = ?, email = ?, password = ?, user_type = ? WHERE id_user = ?',
    [firstName, lastName, email, password, userType, id]
  )
  return { id, ...user }
}

export const partialUpdateUser = async (id, updates) => {
  const [result] = await pool.query('UPDATE User SET ? WHERE id_user = ?', [updates, id])
  return result
}

export const deleteUser = async (id) => {
  await pool.query('DELETE FROM User WHERE id_user = ?', [id])
}
