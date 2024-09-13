import { Router } from 'express'
import { createUserController, deleteUserController, getUser, getUsers, partialUpdateUserController, updateUserController } from '../controllers/user.controller.js'

const router = Router()

router.get('/', getUsers)
router.get('/:id', getUser)
router.post('/', createUserController)
router.put('/:id', updateUserController)
router.patch('/:id', partialUpdateUserController)
router.delete('/:id', deleteUserController)

export default router
