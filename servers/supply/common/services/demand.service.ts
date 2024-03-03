import {
    CustomerId,
    CustomerInfomation,
    CustomerInfomationsClient,
} from './../../../grpc/models/demand'
import * as grpc from '@grpc/grpc-js'
import Logger from '../utils/logger'
import chalk from 'chalk'

class DemandStub {
    private static instance: DemandStub
    private demandsStub: CustomerInfomationsClient

    private constructor() {
        this.demandsStub = new CustomerInfomationsClient(
            `${process.env.DEMAND_GRPC_CLIENT_HOST ?? '127.0.0.1'}:${process.env.DEMAND_GRPC_CLIENT_PORT ?? 50051}`,
            grpc.credentials.createInsecure()
        )

        const deadline = new Date()
        deadline.setSeconds(deadline.getSeconds() + 20)
        this.demandsStub.waitForReady(deadline, (error?: Error) => {
            if (error) {
                Logger.error(`Demand stub connect error: ${error.message}`)
            } else {
                Logger.info(
                    chalk.green('Connect to demand grpc server successfully')
                )
                this.test()
            }
        })
    }

    public static client(): DemandStub {
        return DemandStub.instance ?? (DemandStub.instance = new DemandStub())
    }

    public test() {
        this.find('customer-1002')
    }

    public find(customerId: string): void {
        const message = CustomerId.create({
            id: customerId,
        })

        this.demandsStub.find(message, (err: any, data: CustomerInfomation) => {
            if (err) {
                Logger.error(err)
            } else {
                console.log(data)
            }
        })
    }
}

export default DemandStub
