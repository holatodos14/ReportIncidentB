import multer from 'multer'

const imagesStorage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads')
  },
  filename: function (req, file, cb) {
    const newName = `${Date.now()}-${file.originalname}`
    cb(null, newName)
  }
})

const imagesFilter = (req, file, cb) => {
  const { mimetype } = file
  const mimetypesAllowed = ['image/jpeg', 'image/png']

  if (mimetypesAllowed.includes(mimetype)) {
    cb(null, true)
  } else {
    cb(new Error('Solo archivos JPG o PNG permitidos'))
  }
}

export const uploadImage = multer({ storage: imagesStorage, fileFilter: imagesFilter })
