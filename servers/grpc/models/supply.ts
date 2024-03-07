/* eslint-disable */
import { ChannelCredentials, Client, makeGenericClientConstructor, Metadata } from "@grpc/grpc-js";
import type {
  CallOptions,
  ClientOptions,
  ClientUnaryCall,
  handleUnaryCall,
  ServiceError,
  UntypedServiceImplementation,
} from "@grpc/grpc-js";
import mongoose from "mongoose";
import _m0 from "protobufjs/minimal";

export const protobufPackage = "";

export interface DriverID {
  id: string;
}

export interface DriverInformation {
  // _id: mongoose.Types.ObjectId,
  id: string;
  firstName: string;
  lastName: string;
  password: string;
  dob: string;
  gender: string;
  address: string;
  verified: boolean;
  avatar: string;
  email: string;
}

export interface DriverList {
  drivers: DriverInformation[];
}

export interface DriverEmptyRequest {
}

function createBaseDriverID(): DriverID {
  return { id: "" };
}

export const DriverID = {
  encode(message: DriverID, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): DriverID {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseDriverID();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.id = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): DriverID {
    return { id: isSet(object.id) ? globalThis.String(object.id) : "" };
  },

  toJSON(message: DriverID): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<DriverID>, I>>(base?: I): DriverID {
    return DriverID.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<DriverID>, I>>(object: I): DriverID {
    const message = createBaseDriverID();
    message.id = object.id ?? "";
    return message;
  },
};

function createBaseDriverInformation(): DriverInformation {
  return {
    // _id: mongoose.Types.ObjectId('65e938a62b6d9d523fae6b64'),
    id: "",
    firstName: "",
    lastName: "",
    password: "",
    dob: "",
    gender: "",
    address: "",
    verified: false,
    avatar: "",
    email: "",
  };
}

export const DriverInformation = {
  encode(message: DriverInformation, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    if (message.firstName !== "") {
      writer.uint32(18).string(message.firstName);
    }
    if (message.lastName !== "") {
      writer.uint32(26).string(message.lastName);
    }
    if (message.password !== "") {
      writer.uint32(34).string(message.password);
    }
    if (message.dob !== "") {
      writer.uint32(42).string(message.dob);
    }
    if (message.gender !== "") {
      writer.uint32(50).string(message.gender);
    }
    if (message.address !== "") {
      writer.uint32(58).string(message.address);
    }
    if (message.verified === true) {
      writer.uint32(64).bool(message.verified);
    }
    if (message.avatar !== "") {
      writer.uint32(74).string(message.avatar);
    }
    if (message.email !== "") {
      writer.uint32(82).string(message.email);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): DriverInformation {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseDriverInformation();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.id = reader.string();
          continue;
        case 2:
          if (tag !== 18) {
            break;
          }

          message.firstName = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.lastName = reader.string();
          continue;
        case 4:
          if (tag !== 34) {
            break;
          }

          message.password = reader.string();
          continue;
        case 5:
          if (tag !== 42) {
            break;
          }

          message.dob = reader.string();
          continue;
        case 6:
          if (tag !== 50) {
            break;
          }

          message.gender = reader.string();
          continue;
        case 7:
          if (tag !== 58) {
            break;
          }

          message.address = reader.string();
          continue;
        case 8:
          if (tag !== 64) {
            break;
          }

          message.verified = reader.bool();
          continue;
        case 9:
          if (tag !== 74) {
            break;
          }

          message.avatar = reader.string();
          continue;
        case 10:
          if (tag !== 82) {
            break;
          }

          message.email = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): DriverInformation {
    return {
      id: isSet(object.id) ? globalThis.String(object.id) : "",
      firstName: isSet(object.firstName) ? globalThis.String(object.firstName) : "",
      lastName: isSet(object.lastName) ? globalThis.String(object.lastName) : "",
      password: isSet(object.password) ? globalThis.String(object.password) : "",
      dob: isSet(object.dob) ? globalThis.String(object.dob) : "",
      gender: isSet(object.gender) ? globalThis.String(object.gender) : "",
      address: isSet(object.address) ? globalThis.String(object.address) : "",
      verified: isSet(object.verified) ? globalThis.Boolean(object.verified) : false,
      avatar: isSet(object.avatar) ? globalThis.String(object.avatar) : "",
      email: isSet(object.email) ? globalThis.String(object.email) : "",
    };
  },

  toJSON(message: DriverInformation): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    if (message.firstName !== "") {
      obj.firstName = message.firstName;
    }
    if (message.lastName !== "") {
      obj.lastName = message.lastName;
    }
    if (message.password !== "") {
      obj.password = message.password;
    }
    if (message.dob !== "") {
      obj.dob = message.dob;
    }
    if (message.gender !== "") {
      obj.gender = message.gender;
    }
    if (message.address !== "") {
      obj.address = message.address;
    }
    if (message.verified === true) {
      obj.verified = message.verified;
    }
    if (message.avatar !== "") {
      obj.avatar = message.avatar;
    }
    if (message.email !== "") {
      obj.email = message.email;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<DriverInformation>, I>>(base?: I): DriverInformation {
    return DriverInformation.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<DriverInformation>, I>>(object: I): DriverInformation {
    const message = createBaseDriverInformation();
    message.id = object.id ?? "";
    message.firstName = object.firstName ?? "";
    message.lastName = object.lastName ?? "";
    message.password = object.password ?? "";
    message.dob = object.dob ?? "";
    message.gender = object.gender ?? "";
    message.address = object.address ?? "";
    message.verified = object.verified ?? false;
    message.avatar = object.avatar ?? "";
    message.email = object.email ?? "";
    return message;
  },
};

function createBaseDriverList(): DriverList {
  return { drivers: [] };
}

export const DriverList = {
  encode(message: DriverList, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    for (const v of message.drivers) {
      DriverInformation.encode(v!, writer.uint32(10).fork()).ldelim();
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): DriverList {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseDriverList();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.drivers.push(DriverInformation.decode(reader, reader.uint32()));
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): DriverList {
    return {
      drivers: globalThis.Array.isArray(object?.drivers)
        ? object.drivers.map((e: any) => DriverInformation.fromJSON(e))
        : [],
    };
  },

  toJSON(message: DriverList): unknown {
    const obj: any = {};
    if (message.drivers?.length) {
      obj.drivers = message.drivers.map((e) => DriverInformation.toJSON(e));
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<DriverList>, I>>(base?: I): DriverList {
    return DriverList.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<DriverList>, I>>(object: I): DriverList {
    const message = createBaseDriverList();
    message.drivers = object.drivers?.map((e) => DriverInformation.fromPartial(e)) || [];
    return message;
  },
};

function createBaseDriverEmptyRequest(): DriverEmptyRequest {
  return {};
}

export const DriverEmptyRequest = {
  encode(_: DriverEmptyRequest, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): DriverEmptyRequest {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseDriverEmptyRequest();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(_: any): DriverEmptyRequest {
    return {};
  },

  toJSON(_: DriverEmptyRequest): unknown {
    const obj: any = {};
    return obj;
  },

  create<I extends Exact<DeepPartial<DriverEmptyRequest>, I>>(base?: I): DriverEmptyRequest {
    return DriverEmptyRequest.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<DriverEmptyRequest>, I>>(_: I): DriverEmptyRequest {
    const message = createBaseDriverEmptyRequest();
    return message;
  },
};

export type DriverService = typeof DriverService;
export const DriverService = {
  find: {
    path: "/Driver/find",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: DriverEmptyRequest) => Buffer.from(DriverEmptyRequest.encode(value).finish()),
    requestDeserialize: (value: Buffer) => DriverEmptyRequest.decode(value),
    responseSerialize: (value: DriverList) => Buffer.from(DriverList.encode(value).finish()),
    responseDeserialize: (value: Buffer) => DriverList.decode(value),
  },
  findById: {
    path: "/Driver/findById",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: DriverID) => Buffer.from(DriverID.encode(value).finish()),
    requestDeserialize: (value: Buffer) => DriverID.decode(value),
    responseSerialize: (value: DriverInformation) => Buffer.from(DriverInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => DriverInformation.decode(value),
  },
  verify: {
    path: "/Driver/verify",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: DriverID) => Buffer.from(DriverID.encode(value).finish()),
    requestDeserialize: (value: Buffer) => DriverID.decode(value),
    responseSerialize: (value: DriverInformation) => Buffer.from(DriverInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => DriverInformation.decode(value),
  },
  unverify: {
    path: "/Driver/unverify",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: DriverID) => Buffer.from(DriverID.encode(value).finish()),
    requestDeserialize: (value: Buffer) => DriverID.decode(value),
    responseSerialize: (value: DriverInformation) => Buffer.from(DriverInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => DriverInformation.decode(value),
  },
} as const;

export interface DriverServer extends UntypedServiceImplementation {
  find: handleUnaryCall<DriverEmptyRequest, DriverList>;
  findById: handleUnaryCall<DriverID, DriverInformation>;
  verify: handleUnaryCall<DriverID, DriverInformation>;
  unverify: handleUnaryCall<DriverID, DriverInformation>;
}

export interface DriverClient extends Client {
  find(
    request: DriverEmptyRequest,
    callback: (error: ServiceError | null, response: DriverList) => void,
  ): ClientUnaryCall;
  find(
    request: DriverEmptyRequest,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: DriverList) => void,
  ): ClientUnaryCall;
  find(
    request: DriverEmptyRequest,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: DriverList) => void,
  ): ClientUnaryCall;
  findById(
    request: DriverID,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  findById(
    request: DriverID,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  findById(
    request: DriverID,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  verify(
    request: DriverID,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  verify(
    request: DriverID,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  verify(
    request: DriverID,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  unverify(
    request: DriverID,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  unverify(
    request: DriverID,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
  unverify(
    request: DriverID,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: DriverInformation) => void,
  ): ClientUnaryCall;
}

export const DriverClient = makeGenericClientConstructor(DriverService, "Driver") as unknown as {
  new (address: string, credentials: ChannelCredentials, options?: Partial<ClientOptions>): DriverClient;
  service: typeof DriverService;
  serviceName: string;
};

type Builtin = Date | Function | Uint8Array | string | number | boolean | undefined;

export type DeepPartial<T> = T extends Builtin ? T
  : T extends globalThis.Array<infer U> ? globalThis.Array<DeepPartial<U>>
  : T extends ReadonlyArray<infer U> ? ReadonlyArray<DeepPartial<U>>
  : T extends {} ? { [K in keyof T]?: DeepPartial<T[K]> }
  : Partial<T>;

type KeysOfUnion<T> = T extends T ? keyof T : never;
export type Exact<P, I extends P> = P extends Builtin ? P
  : P & { [K in keyof P]: Exact<P[K], I[K]> } & { [K in Exclude<keyof I, KeysOfUnion<P>>]: never };

function isSet(value: any): boolean {
  return value !== null && value !== undefined;
}
