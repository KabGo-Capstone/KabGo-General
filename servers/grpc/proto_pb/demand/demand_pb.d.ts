// package: 
// file: demand.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";

export class CustomerId extends jspb.Message { 
    getId(): string;
    setId(value: string): CustomerId;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): CustomerId.AsObject;
    static toObject(includeInstance: boolean, msg: CustomerId): CustomerId.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: CustomerId, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): CustomerId;
    static deserializeBinaryFromReader(message: CustomerId, reader: jspb.BinaryReader): CustomerId;
}

export namespace CustomerId {
    export type AsObject = {
        id: string,
    }
}

export class CustomerInfomation extends jspb.Message { 
    getId(): string;
    setId(value: string): CustomerInfomation;
    getFirstname(): string;
    setFirstname(value: string): CustomerInfomation;
    getLastname(): string;
    setLastname(value: string): CustomerInfomation;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): CustomerInfomation.AsObject;
    static toObject(includeInstance: boolean, msg: CustomerInfomation): CustomerInfomation.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: CustomerInfomation, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): CustomerInfomation;
    static deserializeBinaryFromReader(message: CustomerInfomation, reader: jspb.BinaryReader): CustomerInfomation;
}

export namespace CustomerInfomation {
    export type AsObject = {
        id: string,
        firstname: string,
        lastname: string,
    }
}
