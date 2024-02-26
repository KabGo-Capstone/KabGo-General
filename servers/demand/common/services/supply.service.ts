import * as grpc from '@grpc/grpc-js'
import { DriverInfomationsClient } from './../../../grpc/proto_pb/supply/supply_grpc_pb'
import {
    DriverId,
    DriverInfomation,
} from '../../../grpc/proto_pb/supply/supply_pb'
import Logger from '../utils/logger'
import chalk from 'chalk'

class SupplyStub {
    private static instance: SupplyStub
    private supplysStub: DriverInfomationsClient

    private constructor() {
        this.supplysStub = new DriverInfomationsClient(
            '0.0.0.0:50052',
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

    public static connect(): SupplyStub {
        return SupplyStub.instance ?? (SupplyStub.instance = new SupplyStub())
    }

    public test() {
        this.find('driver-1002')
    }

    public find(driverId: string): void {
        const message = new DriverId()
        message.setId(driverId)

        this.supplysStub.find(message, (err: any, data: DriverInfomation) => {
            if (err) {
                Logger.error(err)
            } else {
                console.log(data.toObject())
            }
        })
    }
}

export default SupplyStub
