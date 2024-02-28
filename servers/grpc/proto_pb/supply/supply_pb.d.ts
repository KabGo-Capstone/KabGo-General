// package: 
// file: supply.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";

export class DriverId extends jspb.Message { 
    getId(): string;
    setId(value: string): DriverId;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): DriverId.AsObject;
    static toObject(includeInstance: boolean, msg: DriverId): DriverId.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: DriverId, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): DriverId;
    static deserializeBinaryFromReader(message: DriverId, reader: jspb.BinaryReader): DriverId;
}

export namespace DriverId {
    export type AsObject = {
        id: string,
    }
}

export class DriverInfomation extends jspb.Message { 
    getId(): string;
    setId(value: string): DriverInfomation;
    getFirstname(): string;
    setFirstname(value: string): DriverInfomation;
    getLastname(): string;
    setLastname(value: string): DriverInfomation;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): DriverInfomation.AsObject;
    static toObject(includeInstance: boolean, msg: DriverInfomation): DriverInfomation.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: DriverInfomation, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): DriverInfomation;
    static deserializeBinaryFromReader(message: DriverInfomation, reader: jspb.BinaryReader): DriverInfomation;
}

export namespace DriverInfomation {
    export type AsObject = {
        id: string,
        firstname: string,
        lastname: string,
    }
}
