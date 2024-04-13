import { NextFunction, Request, Response } from 'express'

const catchAsync = (
    callback: (req: Request, res: Response, next: NextFunction) => any
) => {
    return (req: Request, res: Response, next: NextFunction) => {
        callback(req, res, next).catch((err: any) => next(err))
    }
}

export default catchAsync
