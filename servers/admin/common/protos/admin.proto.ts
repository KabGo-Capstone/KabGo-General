import {
    ReqUpdateUrlImage,
    ReqUpdateCurrentAddress,
    ServiceApprovalInformation,
    ServiceInformation,
    ServiceApprovalList,
    ServiceList,
    ServiceApprovalEmptyRequest,
    AdminClient,
    AdminServer
} from './../../../grpc/models/admin'

import * as grpc from '@grpc/grpc-js'

import ServiceApprovalModel from '../models/serviceApproval.model'
import ServiceModel from '../models/service.model'
import VehicleModel from '../models/vehicle.model'

import { getServiceApprovalData } from '../dummy_data/service_approval_data'
import { getServiceData } from '../dummy_data/service_data'
import { getVehicleData } from '../dummy_data/vehicle_data'

class AdminService implements AdminServer {
    [name: string]: grpc.UntypedHandleCall

    public async getServices(
        call: grpc.ServerUnaryCall<ServiceApprovalEmptyRequest, ServiceList>,
        callback: grpc.sendUnaryData<ServiceList>
    ) {
        const SERVICES = await getServiceData();
        const service = SERVICES;

        if (service && service.length > 0) {
            callback(
                null,
                ServiceList.create({
                    services: SERVICES,
                })
            )
        } else {
            callback(
                {
                    message: 'Can not find any services',
                    code: grpc.status.INVALID_ARGUMENT,
                },
                null
            )
        }
    }


    public async uploadUrlImage(
        call: grpc.ServerUnaryCall<ReqUpdateUrlImage, ServiceApprovalInformation>,
        callback: grpc.sendUnaryData<ServiceApprovalInformation>
    ) {
        const SERVICEAPPROVALS = await getServiceApprovalData();
        const serviceApprovalIndex = SERVICEAPPROVALS.findIndex(
            (serviceApproval) => serviceApproval.supplyID === call.request.supplyID
        )

        const serviceApproval = SERVICEAPPROVALS[serviceApprovalIndex]

        await ServiceApprovalModel.updateOne(
            { supplyID: call.request.supplyID }, 
            { [call.request.property]: call.request.url }
        );
        // driver.verified = true

        if (serviceApprovalIndex !== -1) {
            callback(null, ServiceApprovalInformation.create(serviceApproval))
        } else {
            callback(
                {
                    message: 'Service approval not found',
                    code: grpc.status.INVALID_ARGUMENT,
                },
                null
            )
        }
    }

    public async updateCurrentAddress(
        call: grpc.ServerUnaryCall<ReqUpdateCurrentAddress, ServiceApprovalInformation>,
        callback: grpc.sendUnaryData<ServiceApprovalInformation>
    ) {
        const SERVICEAPPROVALS = await getServiceApprovalData();
        const serviceApprovalIndex = SERVICEAPPROVALS.findIndex(
            (serviceApproval) => serviceApproval.supplyID === call.request.supplyID
        )

        const serviceApproval = SERVICEAPPROVALS[serviceApprovalIndex]

        await ServiceApprovalModel.updateOne(
            { supplyID: call.request.supplyID }, 
            { currentAddress: call.request.currentAddress }
        );
        // driver.verified = true

        if (serviceApprovalIndex !== -1) {
            callback(null, ServiceApprovalInformation.create(serviceApproval))
        } else {
            callback(
                {
                    message: 'Service approval not found',
                    code: grpc.status.INVALID_ARGUMENT,
                },
                null
            )
        }
    }

}

export { AdminService }
