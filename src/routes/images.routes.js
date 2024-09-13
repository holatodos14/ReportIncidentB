import { Router } from 'express'
import ImageController from '../controllers/image.controller.js'
import { uploadImage } from '../config/multer.js'

const router = Router()

router.get('/:name', ImageController.sendImage)
router.post('/upload', uploadImage.single('image'), ImageController.uploadImage)

export default router
