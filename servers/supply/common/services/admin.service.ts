import {
    ServiceApprovalInformation,
    ServiceList,
    ServiceApprovalEmptyRequest,
    AdminClient,
    ReqUpdateData,
    ReqCreateData,
    VehicleInformation,
    ReqCreateVehicleData
} from './../../../grpc/models/admin'

import * as grpc from '@grpc/grpc-js'
import Logger from '../utils/logger'
import chalk from 'chalk'

class AdminStub {
    private static instance: AdminStub
    private adminsStub: AdminClient

    private constructor() {
        this.adminsStub = new AdminClient(
            `${process.env.ADMIN_GRPC_CLIENT_HOST ?? '127.0.0.1'}:${process.env.ADMIN_GRPC_CLIENT_PORT ?? 50053}`,
            grpc.credentials.createInsecure()
        )

        const deadline = new Date()
        deadline.setSeconds(deadline.getSeconds() + 20)

        this.adminsStub.waitForReady(deadline, (error?: Error) => {
            if (error) {
                console.log(`Client connect error: ${error.message}`)
            } else {
                Logger.info(
                    chalk.green('Connect to admin grpc server successfully')
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

    public createServiceApproval(
        supplyID: string,
    ) {
        return new Promise<ServiceApprovalInformation>((resolve, reject) => {
            const message = ReqCreateData.create({
                supplyID: supplyID,
            })

            this.adminsStub.createServiceApproval(
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

    public createVehicleInformation(
        supplyID: string,
        name: string,
        identityNumber: string,
        color: string,
        brand: string,
    ) {
        return new Promise<ServiceApprovalInformation>((resolve, reject) => {
            const message = ReqCreateVehicleData.create({
                supplyID: supplyID,
                name: name,
                identityNumber: identityNumber,
                color: color,
                brand: brand,
            })

            this.adminsStub.createVehicleInformation(
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


    public updateServiceApproval(supplyID: string, property: string, value: string) {
        return new Promise<ServiceApprovalInformation>((resolve, reject) => {
            const message = ReqUpdateData.create({
                supplyID: supplyID,
                property: property,
                value: value
            })

            this.adminsStub.updateServiceApproval(
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
