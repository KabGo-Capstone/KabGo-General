import * as grpc from '@grpc/grpc-js'
import {
    CustomerId,
    CustomerInfomation,
    CustomerInfomationsServer,
} from '../../../grpc/models/demand'

const CUSTOMERS = [
    {
        id: 'customer-1002',
        firstname: 'Minh',
        lastname: 'Nguyen',
    },
    {
        id: 'customer-1003',
        firstname: 'Khang',
        lastname: 'Dinh',
    },
]

class CustomerInfomations implements CustomerInfomationsServer {
    [name: string]: grpc.UntypedHandleCall

    public find(
        call: grpc.ServerUnaryCall<CustomerId, CustomerInfomations>,
        callback: grpc.sendUnaryData<CustomerInfomation>
    ) {
        const customer = CUSTOMERS.find(
            (customer) => customer.id === call.request.id
        )

        if (customer) {
            callback(null, CustomerInfomation.create(customer))
        } else {
            callback(
                {
                    message: 'customer not found',
                    code: grpc.status.INVALID_ARGUMENT,
                },
                null
            )
        }
    }
}

export { CustomerInfomations }
