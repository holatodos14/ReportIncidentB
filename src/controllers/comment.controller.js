import { createComment, deleteComment, getCommentById, getCommentsByIncident, updateComment } from '../models/commentModel.js'

export const createCommentController = async (req, res) => {
  try {
    const commentId = await createComment(req.body)
    res.status(201).json({ message: 'Comment created', id: commentId })
  } catch (error) {
    res.status(500).json({ message: 'Error creating comment', error })
  }
}

export const getCommentsByIncidentController = async (req, res) => {
  try {
    const comments = await getCommentsByIncident(req.params.id)
    res.status(200).json(comments)
  } catch (error) {
    res.status(500).json({ message: 'Error fetching comments', error })
  }
}

export const getCommentByIdController = async (req, res) => {
  try {
    const comment = await getCommentById(req.params.id)
    if (comment) {
      res.status(200).json(comment)
    } else {
      res.status(404).json({ message: 'Comment not found' })
    }
  } catch (error) {
    res.status(500).json({ message: 'Error fetching comment', error })
  }
}

export const updateCommentController = async (req, res) => {
  try {
    await updateComment(req.params.id, req.body)
    res.status(200).json({ message: 'Comment updated' })
  } catch (error) {
    res.status(500).json({ message: 'Error updating comment', error })
  }
}

export const deleteCommentController = async (req, res) => {
  try {
    await deleteComment(req.params.id)
    res.status(200).json({ message: 'Comment deleted' })
  } catch (error) {
    res.status(500).json({ message: 'Error deleting comment', error })
  }
}
