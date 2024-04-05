class AppError extends Error {
    public status: string
    public statusCode: number
    public isOperational: boolean

    constructor(message: string, statusCode: number) {
        super(message)

        Object.setPrototypeOf(this, new.target.prototype)

        this.statusCode = statusCode
        this.status = `${statusCode}`.startsWith('4') ? 'failed' : 'error'
        this.isOperational = true

        Error.captureStackTrace(this, this.constructor)
    }
}

export default AppError
