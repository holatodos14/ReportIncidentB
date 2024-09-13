import { pool } from '../config/db.js'

export const createIncident = async (incident) => {
  const [result] = await pool.query('INSERT INTO Incident SET ?', [incident])
  return result.insertId
}

export const getAllIncidents = async () => {
  const [rows] = await pool.query('SELECT * FROM Incident')
  return rows
}

export const getIncidentById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM Incident WHERE idIncident = ?', [id])
  return rows[0]
}

export const updateIncident = async (id, updates) => {
  const [result] = await pool.query('UPDATE Incident SET ? WHERE idIncident = ?', [updates, id])
  return result.affectedRows
}

export const deleteIncident = async (id) => {
  const [result] = await pool.query('DELETE FROM Incident WHERE idIncident = ?', [id])
  return result.affectedRows
}
