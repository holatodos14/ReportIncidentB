import { Router } from 'express'
import { createCommentController, deleteCommentController, getCommentByIdController, getCommentsByIncidentController, updateCommentController } from '../controllers/comment.controller.js'

const router = Router()

router.post('/', createCommentController)
router.get('/incident/:id', getCommentsByIncidentController)
router.get('/:id', getCommentByIdController)
router.patch('/:id', updateCommentController)
router.delete('/:id', deleteCommentController)

export default router
