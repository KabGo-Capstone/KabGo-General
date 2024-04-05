import { NextFunction, Request, Response } from 'express'
import allowedOrigins from '../constants/whitelist.origins'

const credentials = (req: Request, res: Response, next: NextFunction) => {
    const origin = req.headers.origin
    if (origin && allowedOrigins.includes(origin)) {
        res.header('Access-Control-Allow-Credentials', 'true')
    }
    next()
}

export default credentials
