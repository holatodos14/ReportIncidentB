import { createUser, deleteUser, getAllUsers, getUserById, partialUpdateUser, updateUser } from '../models/userModel.js'
import bcrypt from 'bcrypt'

const SALT_ROUNDS = 10

export const getUsers = async (req, res) => {
  try {
    const users = await getAllUsers()
    res.json(users)
  } catch (error) {
    res.status(500).json({ message: 'Error fetching users', error })
  }
}

export const getUser = async (req, res) => {
  try {
    const user = await getUserById(req.params.id)
    if (user) {
      res.json(user)
    } else {
      res.status(404).json({ message: 'User not found' })
    }
  } catch (error) {
    res.status(500).json({ message: 'Error fetching user', error })
  }
}

export const createUserController = async (req, res) => {
  try {
    const { password, ...userData } = req.body

    if (!password) {
      return res.status(400).json({ message: 'Password is required' })
    }

    const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS)

    const newUser = await createUser({ ...userData, password: hashedPassword })

    res.status(201).json(newUser)
  } catch (error) {
    console.error('Error creating user:', error)
    res.status(500).json({ message: 'Error creating user', error: error.message })
  }
}

export const updateUserController = async (req, res) => {
  try {
    const updatedUser = await updateUser(req.params.id, req.body)
    res.json(updatedUser)
  } catch (error) {
    res.status(500).json({ message: 'Error updating user', error })
  }
}

export const partialUpdateUserController = async (req, res) => {
  try {
    const { id } = req.params
    const updates = req.body

    if (!Object.keys(updates).length) {
      return res.status(400).json({ message: 'No data provided for update' })
    }

    const result = await partialUpdateUser(id, updates)

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'User not found' })
    }

    res.json({ message: 'User partially updated' })
  } catch (error) {
    res.status(500).json({ message: 'Error updating user', error })
  }
}

export const deleteUserController = async (req, res) => {
  try {
    await deleteUser(req.params.id)
    res.json({ message: 'User deleted' })
  } catch (error) {
    res.status(500).json({ message: 'Error deleting user', error })
  }
}
