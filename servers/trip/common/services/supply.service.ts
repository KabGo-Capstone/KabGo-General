import {
    DriverClient,
    DriverID,
    DriverInformation,
    DriverList,
    DriverEmptyRequest,
} from './../../../grpc/models/supply'

import * as grpc from '@grpc/grpc-js'
import Logger from '../utils/logger'
import chalk from 'chalk'

class SupplyStub {
    private static instance: SupplyStub
    private supplysStub: DriverClient

    private constructor() {
        this.supplysStub = new DriverClient(
            `${process.env.SUPPLY_GRPC_CLIENT_HOST ?? '127.0.0.1'}:${process.env.SUPPLY_GRPC_CLIENT_PORT ?? 50052}`,
            grpc.credentials.createInsecure()
        )

        const deadline = new Date()
        deadline.setSeconds(deadline.getSeconds() + 20)

        this.supplysStub.waitForReady(deadline, (error?: Error) => {
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

    public static client(): SupplyStub {
        return SupplyStub.instance ?? (SupplyStub.instance = new SupplyStub())
    }

    public test() {
        this.findById('1')
    }

    public find() {
        return new Promise<DriverList>((resolve, reject) => {
            this.supplysStub.find(
                DriverEmptyRequest.create(),
                (error: any, data: DriverList) => {
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

    public findById(driverId: string) {
        return new Promise<DriverInformation>((resolve, reject) => {
            const message = DriverID.create({
                id: driverId,
            })

            this.supplysStub.findById(
                message,
                (err: any, data: DriverInformation) => {
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

    public verify(supplyId: string) {
        return new Promise<DriverInformation>((resolve, reject) => {
            const message = DriverID.create({
                id: supplyId,
            })

            this.supplysStub.verify(
                message,
                (err: any, data: DriverInformation) => {
                    if (err) {
                        reject(err)
                        Logger.error(err)
                    } else {
                        resolve(data)
                        console.log(data)
                    }
                }
            )
        })
    }
}

export default SupplyStub
