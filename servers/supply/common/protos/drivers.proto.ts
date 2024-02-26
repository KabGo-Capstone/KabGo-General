import {
    DriverId,
    DriverInfomation,
} from '../../../grpc/proto_pb/supply/supply_pb'
import { IDriverInfomationsServer } from '../../../grpc/proto_pb/supply/supply_grpc_pb'
import * as grpc from '@grpc/grpc-js'

const DRIVERS = [
    {
        id: 'driver-1002',
        firstname: 'Minh',
        lastname: 'Nguyen',
    },
    {
        id: 'driver-1003',
        firstname: 'Khang',
        lastname: 'Dinh',
    },
]

class DriverInfomations implements IDriverInfomationsServer {
    [name: string]: grpc.UntypedHandleCall

    public find(
        call: grpc.ServerUnaryCall<DriverId, DriverInfomation>,
        callback: grpc.sendUnaryData<DriverInfomation>
    ) {
        const driver = DRIVERS.find(
            (driver) => driver.id === call.request.getId()
        )

        if (driver) {
            const driverInfo = new DriverInfomation()
                .setId(driver.id)
                .setFirstname(driver.firstname)
                .setLastname(driver.lastname)

            callback(null, driverInfo)
        } else {
            callback(
                {
                    message: 'driver not found',
                    code: grpc.status.INVALID_ARGUMENT,
                },
                null
            )
        }
    }
}

export { DriverInfomations }
