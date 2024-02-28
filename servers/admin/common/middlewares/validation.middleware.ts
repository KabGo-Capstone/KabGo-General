import { NextFunction, Response, Request } from 'express'
import { validate, ValidationError } from 'class-validator'
import { plainToInstance } from 'class-transformer'
import AppError from '../services/errors/app.error'

class DTOValidation {
    public static extractParams(params: string[]) {
        return (request: Request, response: Response, next: NextFunction) => {
            params.forEach((key: string) => {
                if (request.params[key]) {
                    request.body[key] = request.params[key]
                }
            })
            return next()
        }
    }

    public static validate<T extends object>(
        dto: new (...args: any[]) => T,
        skipMissingProperties: boolean = false
    ) {
        return (request: Request, response: Response, next: NextFunction) => {
            const instance = plainToInstance(dto, request.body)

            validate(instance, {
                skipMissingProperties,
                whitelist: true,
            }).then((errors: ValidationError[]) => {
                if (errors.length > 0) {
                    const message = errors
                        .map((error: ValidationError) =>
                            Object.values(error.constraints as any)
                        )
                        .join(',')
                        .replace(/,/g, '. ')
                    return next(new AppError(message, 400))
                }

                request.body = instance

                return next()
            })
        }
    }
}

export default DTOValidation
