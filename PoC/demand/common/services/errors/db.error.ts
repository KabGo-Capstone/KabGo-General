import ErrorFactory from '../../services/error.factory'
import AppError from '../../services/errors/app.error'

export class CastError extends ErrorFactory {
    public createError() {
        return new AppError(
            `Invalid ${this.error.path}: ${this.error.value}.`,
            400
        )
    }
}

export class DuplicateFieldsError extends ErrorFactory {
    public createError() {
        const value = this.error.errmsg.match(/(["'])(\\?.)*?\1/)[0]
        return new AppError(
            `Duplicate field value: ${value}. Please use another value.`,
            400
        )
    }
}

export class ValidationError extends ErrorFactory {
    public createError() {
        const errors = Object.values(this.error.errors).map(
            (el: any) => el.message
        )

        const message = `Invalid input data. ${errors.join(' ')}`

        return new AppError(message, 400)
    }
}
