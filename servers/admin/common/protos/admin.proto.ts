import {
    ServiceApprovalInformation,
    ServiceInformation,
    ServiceApprovalList,
    ServiceList,
    ServiceApprovalEmptyRequest,
    AdminClient,
    AdminServer,
    ReqUpdateData,
    ReqCreateData,
    VehicleInformation,
    ReqCreateVehicleData,
    ReqUpdateIdentityInfo,
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
        const SERVICES = await getServiceData()
        const service = SERVICES

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

    public async createServiceApproval(
        call: grpc.ServerUnaryCall<ReqCreateData, ServiceApprovalInformation>,
        callback: grpc.sendUnaryData<ServiceApprovalInformation>
    ) {
        let SERVICEAPPROVALS = await getServiceApprovalData()

        const maxId = Math.max(...SERVICEAPPROVALS.map((el) => parseInt(el.id)))

        await ServiceApprovalModel.create({
            id: (maxId + 1).toString(),
            supplyID: call.request.supplyID,
            serviceID: '1',
            vehicleID: '',
            status: 'pending',
            createdDate: new Date().toDateString(),
            driverLicenseFrontsight: '',
            driverLicenseBacksight: '',
            personalImg: '',
            identityImgFrontsight: '',
            identityImgBacksight: '',
            vehicleImgFrontsight: '',
            vehicleImgBacksight: '',
            vehicleImgLeftsight: '',
            vehicleImgRightsight: '',
            currentAddress: '',
            vehicleRegistrationFrontsight: '',
            vehicleRegistrationBacksight: '',
            vehicleInsuranceFrontsight: '',
            vehicleInsuranceBacksight: '',
        })

        SERVICEAPPROVALS = await getServiceApprovalData()

        const serviceApprovalIndex = SERVICEAPPROVALS.findIndex(
            (serviceApproval) =>
                serviceApproval.supplyID === call.request.supplyID
        )

        const serviceApproval = SERVICEAPPROVALS[serviceApprovalIndex]

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

    public async createVehicleInformation(
        call: grpc.ServerUnaryCall<
            ReqCreateVehicleData,
            ServiceApprovalInformation
        >,
        callback: grpc.sendUnaryData<ServiceApprovalInformation>
    ) {
        const VEHICLES = await getVehicleData()

        const maxId = Math.max(...VEHICLES.map((el) => parseInt(el.id)))

        await VehicleModel.create({
            id: (maxId + 1).toString(),
            name: call.request.name,
            identityNumber: call.request.identityNumber,
            color: call.request.color,
            brand: call.request.brand,
        })

        await ServiceApprovalModel.updateOne(
            { supplyID: call.request.supplyID },
            { vehicleID: (maxId + 1).toString() }
        )

        const SERVICEAPPROVALS = await getServiceApprovalData()

        const serviceApprovalIndex = SERVICEAPPROVALS.findIndex(
            (serviceApproval) =>
                serviceApproval.supplyID === call.request.supplyID
        )

        const serviceApproval = SERVICEAPPROVALS[serviceApprovalIndex]

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

    public async updateServiceApproval(
        call: grpc.ServerUnaryCall<ReqUpdateData, ServiceApprovalInformation>,
        callback: grpc.sendUnaryData<ServiceApprovalInformation>
    ) {
        const SERVICEAPPROVALS = await getServiceApprovalData()

        const serviceApprovalIndex = SERVICEAPPROVALS.findIndex(
            (serviceApproval) =>
                serviceApproval.supplyID === call.request.supplyID
        )

        const serviceApproval = SERVICEAPPROVALS[serviceApprovalIndex]

        await ServiceApprovalModel.updateOne(
            { supplyID: call.request.supplyID },
            { [call.request.property]: call.request.value }
        )
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

    public async updateIdentityInfo(
        call: grpc.ServerUnaryCall<
            ReqUpdateIdentityInfo,
            ServiceApprovalInformation
        >,
        callback: grpc.sendUnaryData<ServiceApprovalInformation>
    ) {
        const SERVICEAPPROVALS = await getServiceApprovalData()

        const serviceApprovalIndex = SERVICEAPPROVALS.findIndex(
            (serviceApproval) =>
                serviceApproval.supplyID === call.request.supplyID
        )

        const serviceApproval = SERVICEAPPROVALS[serviceApprovalIndex]

        await ServiceApprovalModel.updateOne(
            { supplyID: call.request.supplyID },
            {
                identityDate: call.request.identityDate,
                identityLocation: call.request.identityLocation,
            }
        )
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
