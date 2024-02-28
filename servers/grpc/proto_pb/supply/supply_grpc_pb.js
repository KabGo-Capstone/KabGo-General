// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var supply_pb = require('./supply_pb.js');

function serialize_DriverId(arg) {
  if (!(arg instanceof supply_pb.DriverId)) {
    throw new Error('Expected argument of type DriverId');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_DriverId(buffer_arg) {
  return supply_pb.DriverId.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_DriverInfomation(arg) {
  if (!(arg instanceof supply_pb.DriverInfomation)) {
    throw new Error('Expected argument of type DriverInfomation');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_DriverInfomation(buffer_arg) {
  return supply_pb.DriverInfomation.deserializeBinary(new Uint8Array(buffer_arg));
}


var DriverInfomationsService = exports.DriverInfomationsService = {
  find: {
    path: '/DriverInfomations/find',
    requestStream: false,
    responseStream: false,
    requestType: supply_pb.DriverId,
    responseType: supply_pb.DriverInfomation,
    requestSerialize: serialize_DriverId,
    requestDeserialize: deserialize_DriverId,
    responseSerialize: serialize_DriverInfomation,
    responseDeserialize: deserialize_DriverInfomation,
  },
};

exports.DriverInfomationsClient = grpc.makeGenericClientConstructor(DriverInfomationsService);
