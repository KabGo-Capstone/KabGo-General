import {
    DriverID,
    DriverInformation,
    DriverList,
    DriverServer,
    DriverEmptyRequest,
} from './../../../grpc/models/supply'
import * as grpc from '@grpc/grpc-js'
import { supplies as DRIVERS } from '../dummy_data/dummy_data'

class DriverService implements DriverServer {
    [name: string]: grpc.UntypedHandleCall

    public find(
        call: grpc.ServerUnaryCall<DriverEmptyRequest, DriverList>,
        callback: grpc.sendUnaryData<DriverList>
    ) {
        const driver = DRIVERS

        if (driver && driver.length > 0) {
            callback(
                null,
                DriverList.create({
                    drivers: DRIVERS,
                })
            )
        } else {
            callback(
                {
                    message: 'can not find any drivers',
                    code: grpc.status.INVALID_ARGUMENT,
                },
                null
            )
        }
    }

    public findById(
        call: grpc.ServerUnaryCall<DriverID, DriverInformation>,
        callback: grpc.sendUnaryData<DriverInformation>
    ) {
        const driver = DRIVERS.find((driver) => driver.id === call.request.id)

        if (driver) {
            callback(null, DriverInformation.create(driver))
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

    public verify(
        call: grpc.ServerUnaryCall<DriverID, DriverInformation>,
        callback: grpc.sendUnaryData<DriverInformation>
    ) {
        const driverIndex = DRIVERS.findIndex(
            (driver) => driver.id === call.request.id
        )

        const driver = DRIVERS[driverIndex]
        driver.verified = true

        if (driverIndex !== -1) {
            callback(null, DriverInformation.create(driver))
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

export { DriverService }
