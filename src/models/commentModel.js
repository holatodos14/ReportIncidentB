import { pool } from '../config/db.js'

export const createComment = async (comment) => {
  const [result] = await pool.query('INSERT INTO Comment SET ?', [comment])
  return result.insertId
}

export const getCommentsByIncident = async (incidentId) => {
  const [rows] = await pool.query('SELECT * FROM Comment WHERE incidentId = ?', [incidentId])
  return rows
}

export const getCommentById = async (commentId) => {
  const [rows] = await pool.query('SELECT * FROM Comment WHERE commentId = ?', [commentId])
  return rows[0]
}

export const updateComment = async (commentId, updates) => {
  await pool.query('UPDATE Comment SET ? WHERE commentId = ?', [updates, commentId])
}

export const deleteComment = async (commentId) => {
  await pool.query('DELETE FROM Comment WHERE commentId = ?', [commentId])
}
