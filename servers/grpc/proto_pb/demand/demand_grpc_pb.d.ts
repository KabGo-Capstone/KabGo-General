// package: 
// file: demand.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import * as demand_pb from "./demand_pb";

interface ICustomerInfomationsService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    find: ICustomerInfomationsService_Ifind;
}

interface ICustomerInfomationsService_Ifind extends grpc.MethodDefinition<demand_pb.CustomerId, demand_pb.CustomerInfomation> {
    path: "/CustomerInfomations/find";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<demand_pb.CustomerId>;
    requestDeserialize: grpc.deserialize<demand_pb.CustomerId>;
    responseSerialize: grpc.serialize<demand_pb.CustomerInfomation>;
    responseDeserialize: grpc.deserialize<demand_pb.CustomerInfomation>;
}

export const CustomerInfomationsService: ICustomerInfomationsService;

export interface ICustomerInfomationsServer extends grpc.UntypedServiceImplementation {
    find: grpc.handleUnaryCall<demand_pb.CustomerId, demand_pb.CustomerInfomation>;
}

export interface ICustomerInfomationsClient {
    find(request: demand_pb.CustomerId, callback: (error: grpc.ServiceError | null, response: demand_pb.CustomerInfomation) => void): grpc.ClientUnaryCall;
    find(request: demand_pb.CustomerId, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: demand_pb.CustomerInfomation) => void): grpc.ClientUnaryCall;
    find(request: demand_pb.CustomerId, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: demand_pb.CustomerInfomation) => void): grpc.ClientUnaryCall;
}

export class CustomerInfomationsClient extends grpc.Client implements ICustomerInfomationsClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public find(request: demand_pb.CustomerId, callback: (error: grpc.ServiceError | null, response: demand_pb.CustomerInfomation) => void): grpc.ClientUnaryCall;
    public find(request: demand_pb.CustomerId, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: demand_pb.CustomerInfomation) => void): grpc.ClientUnaryCall;
    public find(request: demand_pb.CustomerId, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: demand_pb.CustomerInfomation) => void): grpc.ClientUnaryCall;
}
