import express from 'express'
import morgan from 'morgan'
import { PORT } from './config/config.js'
import users from './routes/users.routes.js'
import incidentsRouter from './routes/incident.routes.js'
import commentsRouter from './routes/comment.routes.js'
import http from 'http'
import { Server } from 'socket.io'
import { validateCORS } from './middlewares/middleware.js'
import authRoutes from './routes/auth.routes.js'
import imageRoutes from './routes/images.routes.js'

const app = express()
const server = http.createServer(app)
const io = new Server(server, {
  cors: {
    origin: 'http://localhost:5173',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['my-custom-header'],
    credentials: true
  }
})

app.use(morgan('dev'))
app.use(express.json())
app.use(validateCORS)

app.use('/api/users', users)
app.use('/api/auth', authRoutes)
app.use('/api/incidents', incidentsRouter)
app.use('/api/comments', commentsRouter)
app.use('/api/images', imageRoutes)

io.on('connection', (socket) => {
  console.log('New client connected')
  socket.on('newComment', (data) => {
    io.emit('updateComment', data)
  })

  socket.on('disconnect', () => {
    console.log('Client disconnected')
  })
})

server.listen(PORT, () => console.log(`Server is running on http://localhost:${PORT}`))
