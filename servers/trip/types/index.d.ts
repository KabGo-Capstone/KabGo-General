import { IUser } from '../common/models/user.example.model'
import { IDCustomerSocket } from '../common/interfaces/customer.socket'
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
    interface IODCustomerSocket {
        [key: string]: IDCustomerSocket
    }

    interface Server {
        customer_sockets: IODCustomerSocket
    }
}

declare const _default: {
    generate: (length?: number, options?: otpOptions) => string
}
export = _default
