import AppError from '../services/errors/app.error'

interface IError {
    createError(): AppError
}

export default IError
