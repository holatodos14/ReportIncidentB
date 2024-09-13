import path from 'node:path'
import fs from 'node:fs/promises'

class ImageController {
  static async sendImage (req, res) {
    try {
      const { name } = req.params
      if (!name) return res.status(400).json({ message: 'Image name must be provided' })

      const imagePath = path.resolve(`./uploads/${name}`)
      await fs.access(imagePath)
    } catch (error) {
      if (error?.errno === -4058) return res.status(404).json({ message: 'Image does not exist' })

      res.status(500).json({ message: error.message })
    }
  }
}

export default ImageController
