import {
    ReqUpdateUrlImage,
    ReqUpdateCurrentAddress,
    ServiceApprovalInformation,
    ServiceInformation,
    ServiceApprovalList,
    ServiceList,
    ServiceApprovalEmptyRequest,
    AdminClient
} from './../../../grpc/models/admin'

import * as grpc from '@grpc/grpc-js'
import Logger from '../utils/logger'
import chalk from 'chalk'

class AdminStub {
    private static instance: AdminStub
    private adminsStub: AdminClient

    private constructor() {
        this.adminsStub = new AdminClient(
            `${process.env.ADMIN_GRPC_CLIENT_HOST ?? '127.0.0.1'}:${process.env.ADMIN_GRPC_CLIENT_PORT ?? 50052}`,
            grpc.credentials.createInsecure()
        )

        const deadline = new Date()
        deadline.setSeconds(deadline.getSeconds() + 20)

        this.adminsStub.waitForReady(deadline, (error?: Error) => {
            if (error) {
                console.log(`Client connect error: ${error.message}`)
            } else {
                Logger.info(
                    chalk.green('Connect to supply grpc server successfully')
                )
                this.test()
            }
        })
    }

    public static client(): AdminStub {
        return AdminStub.instance ?? (AdminStub.instance = new AdminStub())
    }

    public test() {
        this.getServices()
    }

    public getServices() {
        return new Promise<ServiceList>((resolve, reject) => {
            this.adminsStub.getServices(
                ServiceApprovalEmptyRequest.create(),
                (error: any, data: ServiceList) => {
                    if (error) {
                        reject(error)
                        Logger.error(error)
                    } else {
                        resolve(data)
                    }
                }
            )
        })
    }

    public uploadUrlImage(url: string, supplyID: string, property: string) {
        return new Promise<ServiceApprovalInformation>((resolve, reject) => {
            const message = ReqUpdateUrlImage.create({
                url: url,
                supplyID: supplyID,
                property: property
            })

            this.adminsStub.uploadUrlImage(
                message,
                (err: any, data: ServiceApprovalInformation) => {
                    if (err) {
                        reject(err)
                        Logger.error(err)
                    } else {
                        resolve(data)
                        // console.log(data)
                    }
                }
            )
        })
    }

    public updateCurrentAddress(supplyID: string, currentAddress: string) {
        return new Promise<ServiceApprovalInformation>((resolve, reject) => {
            const message = ReqUpdateCurrentAddress.create({
                supplyID: supplyID,
                currentAddress: currentAddress
            })

            this.adminsStub.updateCurrentAddress(
                message,
                (err: any, data: ServiceApprovalInformation) => {
                    if (err) {
                        reject(err)
                        Logger.error(err)
                    } else {
                        resolve(data)
                        // console.log(data)
                    }
                }
            )
        })
    }

}

export default AdminStub
