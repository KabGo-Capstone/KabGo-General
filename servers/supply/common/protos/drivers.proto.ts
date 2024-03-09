import {
    DriverID,
    DriverInformation,
    DriverList,
    DriverServer,
    DriverEmptyRequest,
} from './../../../grpc/models/supply'
import * as grpc from '@grpc/grpc-js'
// import { supplies as DRIVERS } from '../dummy_data/dummy_data'

import { getSupplies } from '../dummy_data/mongoose_data'
import DriverModel from 'common/models/driver.model';

class DriverService implements DriverServer {
    [name: string]: grpc.UntypedHandleCall

    public async find(
        call: grpc.ServerUnaryCall<DriverEmptyRequest, DriverList>,
        callback: grpc.sendUnaryData<DriverList>
    ) {
        const DRIVERS = await getSupplies();
        const driver = DRIVERS;

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

    public async findById(
        call: grpc.ServerUnaryCall<DriverID, DriverInformation>,
        callback: grpc.sendUnaryData<DriverInformation>
    ) {
        const DRIVERS = await getSupplies();
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

    public async verify(
        call: grpc.ServerUnaryCall<DriverID, DriverInformation>,
        callback: grpc.sendUnaryData<DriverInformation>
    ) {
        const DRIVERS = await getSupplies();
        const driverIndex = DRIVERS.findIndex(
            (driver) => driver.id === call.request.id
        )

        const driver = DRIVERS[driverIndex]
        await DriverModel.updateOne({ id: call.request.id }, { verified: true });
        // driver.verified = true

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

    public async unverify(
        call: grpc.ServerUnaryCall<DriverID, DriverInformation>,
        callback: grpc.sendUnaryData<DriverInformation>
    ) {

        const DRIVERS = await getSupplies();

        const driverIndex = DRIVERS.findIndex(
            (driver) => driver.id === call.request.id
        )

        const driver = DRIVERS[driverIndex]
        await DriverModel.updateOne({ id: call.request.id }, { verified: false });
        // driver.verified = false

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
