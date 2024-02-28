// package: 
// file: supply.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import * as supply_pb from "./supply_pb";

interface IDriverInfomationsService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    find: IDriverInfomationsService_Ifind;
}

interface IDriverInfomationsService_Ifind extends grpc.MethodDefinition<supply_pb.DriverId, supply_pb.DriverInfomation> {
    path: "/DriverInfomations/find";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<supply_pb.DriverId>;
    requestDeserialize: grpc.deserialize<supply_pb.DriverId>;
    responseSerialize: grpc.serialize<supply_pb.DriverInfomation>;
    responseDeserialize: grpc.deserialize<supply_pb.DriverInfomation>;
}

export const DriverInfomationsService: IDriverInfomationsService;

export interface IDriverInfomationsServer extends grpc.UntypedServiceImplementation {
    find: grpc.handleUnaryCall<supply_pb.DriverId, supply_pb.DriverInfomation>;
}

export interface IDriverInfomationsClient {
    find(request: supply_pb.DriverId, callback: (error: grpc.ServiceError | null, response: supply_pb.DriverInfomation) => void): grpc.ClientUnaryCall;
    find(request: supply_pb.DriverId, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: supply_pb.DriverInfomation) => void): grpc.ClientUnaryCall;
    find(request: supply_pb.DriverId, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: supply_pb.DriverInfomation) => void): grpc.ClientUnaryCall;
}

export class DriverInfomationsClient extends grpc.Client implements IDriverInfomationsClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public find(request: supply_pb.DriverId, callback: (error: grpc.ServiceError | null, response: supply_pb.DriverInfomation) => void): grpc.ClientUnaryCall;
    public find(request: supply_pb.DriverId, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: supply_pb.DriverInfomation) => void): grpc.ClientUnaryCall;
    public find(request: supply_pb.DriverId, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: supply_pb.DriverInfomation) => void): grpc.ClientUnaryCall;
}
