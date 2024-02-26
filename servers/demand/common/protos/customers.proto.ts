import { ICustomerInfomationsServer } from './../../../grpc/proto_pb/demand/demand_grpc_pb'
import {
    CustomerId,
    CustomerInfomation,
} from './../../../grpc/proto_pb/demand/demand_pb'
import * as grpc from '@grpc/grpc-js'

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

class CustomerInfomations implements ICustomerInfomationsServer {
    [name: string]: grpc.UntypedHandleCall

    public find(
        call: grpc.ServerUnaryCall<CustomerId, CustomerInfomation>,
        callback: grpc.sendUnaryData<CustomerInfomation>
    ) {
        const customer = CUSTOMERS.find(
            (customer) => customer.id === call.request.getId()
        )

        if (customer) {
            const customerInfo = new CustomerInfomation()
                .setId(customer.id)
                .setFirstname(customer.firstname)
                .setLastname(customer.lastname)

            callback(null, customerInfo)
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
