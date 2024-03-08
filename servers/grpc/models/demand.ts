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
import _m0 from "protobufjs/minimal";

export const protobufPackage = "";

export interface CustomerId {
  id: string;
}

export interface CustomerInfomation {
  id: string;
  firstname: string;
  lastname: string;
}

function createBaseCustomerId(): CustomerId {
  return { id: "" };
}

export const CustomerId = {
  encode(message: CustomerId, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): CustomerId {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseCustomerId();
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

  fromJSON(object: any): CustomerId {
    return { id: isSet(object.id) ? globalThis.String(object.id) : "" };
  },

  toJSON(message: CustomerId): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<CustomerId>, I>>(base?: I): CustomerId {
    return CustomerId.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<CustomerId>, I>>(object: I): CustomerId {
    const message = createBaseCustomerId();
    message.id = object.id ?? "";
    return message;
  },
};

function createBaseCustomerInfomation(): CustomerInfomation {
  return { id: "", firstname: "", lastname: "" };
}

export const CustomerInfomation = {
  encode(message: CustomerInfomation, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    if (message.firstname !== "") {
      writer.uint32(18).string(message.firstname);
    }
    if (message.lastname !== "") {
      writer.uint32(26).string(message.lastname);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): CustomerInfomation {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseCustomerInfomation();
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

          message.firstname = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.lastname = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): CustomerInfomation {
    return {
      id: isSet(object.id) ? globalThis.String(object.id) : "",
      firstname: isSet(object.firstname) ? globalThis.String(object.firstname) : "",
      lastname: isSet(object.lastname) ? globalThis.String(object.lastname) : "",
    };
  },

  toJSON(message: CustomerInfomation): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    if (message.firstname !== "") {
      obj.firstname = message.firstname;
    }
    if (message.lastname !== "") {
      obj.lastname = message.lastname;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<CustomerInfomation>, I>>(base?: I): CustomerInfomation {
    return CustomerInfomation.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<CustomerInfomation>, I>>(object: I): CustomerInfomation {
    const message = createBaseCustomerInfomation();
    message.id = object.id ?? "";
    message.firstname = object.firstname ?? "";
    message.lastname = object.lastname ?? "";
    return message;
  },
};

export type CustomerInfomationsService = typeof CustomerInfomationsService;
export const CustomerInfomationsService = {
  find: {
    path: "/CustomerInfomations/find",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: CustomerId) => Buffer.from(CustomerId.encode(value).finish()),
    requestDeserialize: (value: Buffer) => CustomerId.decode(value),
    responseSerialize: (value: CustomerInfomation) => Buffer.from(CustomerInfomation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => CustomerInfomation.decode(value),
  },
} as const;

export interface CustomerInfomationsServer extends UntypedServiceImplementation {
  find: handleUnaryCall<CustomerId, CustomerInfomation>;
}

export interface CustomerInfomationsClient extends Client {
  find(
    request: CustomerId,
    callback: (error: ServiceError | null, response: CustomerInfomation) => void,
  ): ClientUnaryCall;
  find(
    request: CustomerId,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: CustomerInfomation) => void,
  ): ClientUnaryCall;
  find(
    request: CustomerId,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: CustomerInfomation) => void,
  ): ClientUnaryCall;
}

export const CustomerInfomationsClient = makeGenericClientConstructor(
  CustomerInfomationsService,
  "CustomerInfomations",
) as unknown as {
  new (address: string, credentials: ChannelCredentials, options?: Partial<ClientOptions>): CustomerInfomationsClient;
  service: typeof CustomerInfomationsService;
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
