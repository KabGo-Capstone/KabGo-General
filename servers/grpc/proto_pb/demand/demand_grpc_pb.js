// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var demand_pb = require('./demand_pb.js');

function serialize_CustomerId(arg) {
  if (!(arg instanceof demand_pb.CustomerId)) {
    throw new Error('Expected argument of type CustomerId');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_CustomerId(buffer_arg) {
  return demand_pb.CustomerId.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_CustomerInfomation(arg) {
  if (!(arg instanceof demand_pb.CustomerInfomation)) {
    throw new Error('Expected argument of type CustomerInfomation');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_CustomerInfomation(buffer_arg) {
  return demand_pb.CustomerInfomation.deserializeBinary(new Uint8Array(buffer_arg));
}


var CustomerInfomationsService = exports.CustomerInfomationsService = {
  find: {
    path: '/CustomerInfomations/find',
    requestStream: false,
    responseStream: false,
    requestType: demand_pb.CustomerId,
    responseType: demand_pb.CustomerInfomation,
    requestSerialize: serialize_CustomerId,
    requestDeserialize: deserialize_CustomerId,
    responseSerialize: serialize_CustomerInfomation,
    responseDeserialize: deserialize_CustomerInfomation,
  },
};

exports.CustomerInfomationsClient = grpc.makeGenericClientConstructor(CustomerInfomationsService);
