import { Router } from 'express'
import { createIncidentController, deleteIncidentController, getAllIncidentsController, getIncidentByIdController, updateIncidentController } from '../controllers/incident.controller.js'
import { uploadImage } from '../config/multer.js'

const router = Router()

router.post('/', uploadImage.single('profile'), createIncidentController)
router.get('/', getAllIncidentsController)
router.get('/:id', getIncidentByIdController)
router.patch('/:id', updateIncidentController)
router.delete('/:id', deleteIncidentController)

export default router
