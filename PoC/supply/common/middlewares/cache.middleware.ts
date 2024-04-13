import redis from '../services/redis'
import AppError from '../services/errors/app.error'
import { NextFunction, Response, Request } from 'express'
import Logger from '../utils/logger'

const cacheMiddleware = (
    keyGetter: (request: Request) => string,
    callback: (
        req: Request,
        res: Response,
        next: NextFunction,
        data: any
    ) => any
) => {
    return async (request: Request, response: Response, next: NextFunction) => {
        try {
            const redisClient = redis.getClient()

            const key = keyGetter(request)

            if (!key || !redisClient) return next()

            const cachedResponse = await redisClient?.get(key)

            if (cachedResponse) {
                return callback(
                    request,
                    response,
                    next,
                    JSON.parse(cachedResponse)
                )
            }

            return next()
        } catch (error) {
            Logger.error(error)
            return next(new AppError('Error on cache middleware', 500))
        }
    }
}

export default cacheMiddleware
