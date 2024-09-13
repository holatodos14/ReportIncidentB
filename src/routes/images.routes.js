import { Router } from 'express'
import ImageController from '../controllers/image.controller.js'

const router = Router()

router.get('/:name', ImageController.sendImage)

export default router
