const allowedOrigins = [
    process.env.CLIENT_HOST,
    process.env.CLIENT_SOCKET_HOST,
    'http://127.0.0.1:3000',
    'http://127.0.0.1:3001',
    'http://127.0.0.1:5500',
    'http://localhost:3000',
    'http://localhost:3001',
]

export default allowedOrigins
