import { IUser } from '../common/models/user.example.model'
import { IDriverSocket } from '../common/interfaces/driver.socket'
import { ICustomerSocket } from '../common/interfaces/customer.socket'
import { UploadApiResponse } from 'cloudinary'
import { Options as otpOptions } from '../common/utils/otp-generator'
declare global {
    namespace Express {
        export interface User extends IUser {}
        export interface Request {
            user?: IUser
            verification_code?: string
            cloudinaryResult: UploadApiResponse
        }
    }
}

declare module 'socket.io' {
    interface IODriverSocket {
        [key: string]: IDriverSocket
    }
    interface IODriverSocket {
        [key: string]: ICustomerSocket
    }

    interface Server {
        driver_sockets: IODriverSocket
        customer_sockets: IOCustomerSocket
    }
}

declare const _default: {
    generate: (length?: number, options?: otpOptions) => string
}
export = _default
