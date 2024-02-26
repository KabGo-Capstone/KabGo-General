import * as grpc from '@grpc/grpc-js'
import { CustomerInfomationsClient } from './../../../grpc/proto_pb/demand/demand_grpc_pb'
import {
    CustomerId,
    CustomerInfomation,
} from '../../../grpc/proto_pb/demand/demand_pb'
import Logger from '../utils/logger'
import chalk from 'chalk'

class DemandStub {
    private static instance: DemandStub
    private demandsStub: CustomerInfomationsClient

    private constructor() {
        this.demandsStub = new CustomerInfomationsClient(
            '0.0.0.0:50051',
            grpc.credentials.createInsecure()
        )

        const deadline = new Date()
        deadline.setSeconds(deadline.getSeconds() + 20)
        this.demandsStub.waitForReady(deadline, (error?: Error) => {
            if (error) {
                console.log(`Client connect error: ${error.message}`)
            } else {
                Logger.info(
                    chalk.green('Connect to demand grpc server successfully')
                )
                this.test()
            }
        })
    }

    public static connect(): DemandStub {
        return DemandStub.instance ?? (DemandStub.instance = new DemandStub())
    }

    public test() {
        this.find('customer-1002')
    }

    public find(driverId: string): void {
        const message = new CustomerId()
        message.setId(driverId)

        this.demandsStub.find(message, (err: any, data: CustomerInfomation) => {
            if (err) {
                Logger.error(err)
            } else {
                console.log(data.toObject())
            }
        })
    }
}

export default DemandStub
