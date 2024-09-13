import { createIncident, deleteIncident, getAllIncidents, getIncidentById, updateIncident } from '../models/incidentModel.js'

export const createIncidentController = async (req, res) => {
  try {
    const incidentId = await createIncident(req.body)
    res.status(201).json({ message: 'Incident created', id: incidentId })
  } catch (error) {
    res.status(500).json({ message: 'Error creating incident', error })
  }
}

export const getAllIncidentsController = async (req, res) => {
  try {
    const incidents = await getAllIncidents()
    res.json(incidents)
  } catch (error) {
    res.status(500).json({ message: 'Error fetching incidents', error })
  }
}

export const getIncidentByIdController = async (req, res) => {
  try {
    const incident = await getIncidentById(req.params.id)
    if (!incident) {
      return res.status(404).json({ message: 'Incident not found' })
    }
    res.json(incident)
  } catch (error) {
    res.status(500).json({ message: 'Error fetching incident', error })
  }
}

export const updateIncidentController = async (req, res) => {
  try {
    const updatedRows = await updateIncident(req.params.id, req.body)
    if (updatedRows === 0) {
      return res.status(404).json({ message: 'Incident not found' })
    }
    res.json({ message: 'Incident partially updated' })
  } catch (error) {
    res.status(500).json({ message: 'Error updating incident', error })
  }
}

export const deleteIncidentController = async (req, res) => {
  try {
    const deletedRows = await deleteIncident(req.params.id)
    if (deletedRows === 0) {
      return res.status(404).json({ message: 'Incident not found' })
    }
    res.json({ message: 'Incident deleted' })
  } catch (error) {
    res.status(500).json({ message: 'Error deleting incident', error })
  }
}
