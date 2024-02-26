import { IUser } from '../common/models/user.example.model'
import { UploadApiResponse } from 'cloudinary'
import { Options as otpOptions } from '../common/utils/otp-generator'
declare global {
    namespace Express {
        export interface User extends IUser {}
        export interface Request {
            //example
            user?: IUser
            verification_code?: string
            cloudinaryResult: UploadApiResponse
        }
    }
}

declare module 'socket.io' {
    interface Socket {
        //example
        user: IUser
    }
    interface Server {
        //example
        socket_list: Socket[]
    }
}

declare const _default: {
    generate: (length?: number, options?: otpOptions) => string
}
export = _default
