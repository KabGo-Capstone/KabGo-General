import { CorsOptions } from 'cors'
import allowedOrigins from '../constants/whitelist.origins'
import AppError from '../services/errors/app.error'

const CorsCustomOptions = {
    origin: (origin: string, callback: any) => {
        if (
            allowedOrigins.length === 0 ||
            allowedOrigins.indexOf(origin) !== -1 ||
            !origin
        )
            callback(null, true)
        else callback(new AppError('Not allowed by CORS', 401))
    },
    optionsSuccessStatus: 200,
} as CorsOptions

export default CorsCustomOptions
