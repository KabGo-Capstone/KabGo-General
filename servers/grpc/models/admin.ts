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

export interface ReqUpdateData {
  supplyID: string;
  property: string;
  value: string;
}

export interface ReqUpdateIdentityInfo {
  supplyID: string;
  identityDate: string;
  identityLocation: string;
}

export interface ReqCreateData {
  supplyID: string;
}

export interface ServiceApprovalInformation {
  id: string;
  supplyID: string;
  serviceID: string;
  vehicleID: string;
  status: string;
  createdDate: string;
  driverLicenseFrontsight: string;
  driverLicenseBacksight: string;
  personalImg: string;
  identityImgFrontsight: string;
  identityImgBacksight: string;
  vehicleImgFrontsight: string;
  vehicleImgBacksight: string;
  vehicleImgLeftsight: string;
  vehicleImgRightsight: string;
  currentAddress: string;
  vehicleRegistrationFrontsight: string;
  vehicleRegistrationBacksight: string;
  vehicleInsuranceFrontsight: string;
  vehicleInsuranceBacksight: string;
  identityDate: string;
  identityLocation: string;
}

export interface ServiceInformation {
  id: string;
  name: string;
  description: string;
  basePrice: number;
}

export interface ReqCreateVehicleData {
  supplyID: string;
  name: string;
  identityNumber: string;
  color: string;
  brand: string;
}

export interface VehicleInformation {
  id: string;
  name: string;
  identityNumber: string;
  color: string;
  brand: string;
}

export interface ServiceApprovalList {
  serviceApprovals: ServiceApprovalInformation[];
}

export interface ServiceList {
  services: ServiceInformation[];
}

export interface ServiceApprovalEmptyRequest {
}

function createBaseReqUpdateData(): ReqUpdateData {
  return { supplyID: "", property: "", value: "" };
}

export const ReqUpdateData = {
  encode(message: ReqUpdateData, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.supplyID !== "") {
      writer.uint32(10).string(message.supplyID);
    }
    if (message.property !== "") {
      writer.uint32(18).string(message.property);
    }
    if (message.value !== "") {
      writer.uint32(26).string(message.value);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ReqUpdateData {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseReqUpdateData();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.supplyID = reader.string();
          continue;
        case 2:
          if (tag !== 18) {
            break;
          }

          message.property = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.value = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ReqUpdateData {
    return {
      supplyID: isSet(object.supplyID) ? globalThis.String(object.supplyID) : "",
      property: isSet(object.property) ? globalThis.String(object.property) : "",
      value: isSet(object.value) ? globalThis.String(object.value) : "",
    };
  },

  toJSON(message: ReqUpdateData): unknown {
    const obj: any = {};
    if (message.supplyID !== "") {
      obj.supplyID = message.supplyID;
    }
    if (message.property !== "") {
      obj.property = message.property;
    }
    if (message.value !== "") {
      obj.value = message.value;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ReqUpdateData>, I>>(base?: I): ReqUpdateData {
    return ReqUpdateData.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ReqUpdateData>, I>>(object: I): ReqUpdateData {
    const message = createBaseReqUpdateData();
    message.supplyID = object.supplyID ?? "";
    message.property = object.property ?? "";
    message.value = object.value ?? "";
    return message;
  },
};

function createBaseReqUpdateIdentityInfo(): ReqUpdateIdentityInfo {
  return { supplyID: "", identityDate: "", identityLocation: "" };
}

export const ReqUpdateIdentityInfo = {
  encode(message: ReqUpdateIdentityInfo, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.supplyID !== "") {
      writer.uint32(10).string(message.supplyID);
    }
    if (message.identityDate !== "") {
      writer.uint32(18).string(message.identityDate);
    }
    if (message.identityLocation !== "") {
      writer.uint32(26).string(message.identityLocation);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ReqUpdateIdentityInfo {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseReqUpdateIdentityInfo();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.supplyID = reader.string();
          continue;
        case 2:
          if (tag !== 18) {
            break;
          }

          message.identityDate = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.identityLocation = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ReqUpdateIdentityInfo {
    return {
      supplyID: isSet(object.supplyID) ? globalThis.String(object.supplyID) : "",
      identityDate: isSet(object.identityDate) ? globalThis.String(object.identityDate) : "",
      identityLocation: isSet(object.identityLocation) ? globalThis.String(object.identityLocation) : "",
    };
  },

  toJSON(message: ReqUpdateIdentityInfo): unknown {
    const obj: any = {};
    if (message.supplyID !== "") {
      obj.supplyID = message.supplyID;
    }
    if (message.identityDate !== "") {
      obj.identityDate = message.identityDate;
    }
    if (message.identityLocation !== "") {
      obj.identityLocation = message.identityLocation;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ReqUpdateIdentityInfo>, I>>(base?: I): ReqUpdateIdentityInfo {
    return ReqUpdateIdentityInfo.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ReqUpdateIdentityInfo>, I>>(object: I): ReqUpdateIdentityInfo {
    const message = createBaseReqUpdateIdentityInfo();
    message.supplyID = object.supplyID ?? "";
    message.identityDate = object.identityDate ?? "";
    message.identityLocation = object.identityLocation ?? "";
    return message;
  },
};

function createBaseReqCreateData(): ReqCreateData {
  return { supplyID: "" };
}

export const ReqCreateData = {
  encode(message: ReqCreateData, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.supplyID !== "") {
      writer.uint32(10).string(message.supplyID);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ReqCreateData {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseReqCreateData();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.supplyID = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ReqCreateData {
    return { supplyID: isSet(object.supplyID) ? globalThis.String(object.supplyID) : "" };
  },

  toJSON(message: ReqCreateData): unknown {
    const obj: any = {};
    if (message.supplyID !== "") {
      obj.supplyID = message.supplyID;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ReqCreateData>, I>>(base?: I): ReqCreateData {
    return ReqCreateData.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ReqCreateData>, I>>(object: I): ReqCreateData {
    const message = createBaseReqCreateData();
    message.supplyID = object.supplyID ?? "";
    return message;
  },
};

function createBaseServiceApprovalInformation(): ServiceApprovalInformation {
  return {
    id: "",
    supplyID: "",
    serviceID: "",
    vehicleID: "",
    status: "",
    createdDate: "",
    driverLicenseFrontsight: "",
    driverLicenseBacksight: "",
    personalImg: "",
    identityImgFrontsight: "",
    identityImgBacksight: "",
    vehicleImgFrontsight: "",
    vehicleImgBacksight: "",
    vehicleImgLeftsight: "",
    vehicleImgRightsight: "",
    currentAddress: "",
    vehicleRegistrationFrontsight: "",
    vehicleRegistrationBacksight: "",
    vehicleInsuranceFrontsight: "",
    vehicleInsuranceBacksight: "",
    identityDate: "",
    identityLocation: "",
  };
}

export const ServiceApprovalInformation = {
  encode(message: ServiceApprovalInformation, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    if (message.supplyID !== "") {
      writer.uint32(18).string(message.supplyID);
    }
    if (message.serviceID !== "") {
      writer.uint32(26).string(message.serviceID);
    }
    if (message.vehicleID !== "") {
      writer.uint32(34).string(message.vehicleID);
    }
    if (message.status !== "") {
      writer.uint32(42).string(message.status);
    }
    if (message.createdDate !== "") {
      writer.uint32(50).string(message.createdDate);
    }
    if (message.driverLicenseFrontsight !== "") {
      writer.uint32(58).string(message.driverLicenseFrontsight);
    }
    if (message.driverLicenseBacksight !== "") {
      writer.uint32(66).string(message.driverLicenseBacksight);
    }
    if (message.personalImg !== "") {
      writer.uint32(74).string(message.personalImg);
    }
    if (message.identityImgFrontsight !== "") {
      writer.uint32(82).string(message.identityImgFrontsight);
    }
    if (message.identityImgBacksight !== "") {
      writer.uint32(90).string(message.identityImgBacksight);
    }
    if (message.vehicleImgFrontsight !== "") {
      writer.uint32(98).string(message.vehicleImgFrontsight);
    }
    if (message.vehicleImgBacksight !== "") {
      writer.uint32(106).string(message.vehicleImgBacksight);
    }
    if (message.vehicleImgLeftsight !== "") {
      writer.uint32(114).string(message.vehicleImgLeftsight);
    }
    if (message.vehicleImgRightsight !== "") {
      writer.uint32(122).string(message.vehicleImgRightsight);
    }
    if (message.currentAddress !== "") {
      writer.uint32(130).string(message.currentAddress);
    }
    if (message.vehicleRegistrationFrontsight !== "") {
      writer.uint32(138).string(message.vehicleRegistrationFrontsight);
    }
    if (message.vehicleRegistrationBacksight !== "") {
      writer.uint32(146).string(message.vehicleRegistrationBacksight);
    }
    if (message.vehicleInsuranceFrontsight !== "") {
      writer.uint32(154).string(message.vehicleInsuranceFrontsight);
    }
    if (message.vehicleInsuranceBacksight !== "") {
      writer.uint32(162).string(message.vehicleInsuranceBacksight);
    }
    if (message.identityDate !== "") {
      writer.uint32(170).string(message.identityDate);
    }
    if (message.identityLocation !== "") {
      writer.uint32(178).string(message.identityLocation);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ServiceApprovalInformation {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseServiceApprovalInformation();
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

          message.supplyID = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.serviceID = reader.string();
          continue;
        case 4:
          if (tag !== 34) {
            break;
          }

          message.vehicleID = reader.string();
          continue;
        case 5:
          if (tag !== 42) {
            break;
          }

          message.status = reader.string();
          continue;
        case 6:
          if (tag !== 50) {
            break;
          }

          message.createdDate = reader.string();
          continue;
        case 7:
          if (tag !== 58) {
            break;
          }

          message.driverLicenseFrontsight = reader.string();
          continue;
        case 8:
          if (tag !== 66) {
            break;
          }

          message.driverLicenseBacksight = reader.string();
          continue;
        case 9:
          if (tag !== 74) {
            break;
          }

          message.personalImg = reader.string();
          continue;
        case 10:
          if (tag !== 82) {
            break;
          }

          message.identityImgFrontsight = reader.string();
          continue;
        case 11:
          if (tag !== 90) {
            break;
          }

          message.identityImgBacksight = reader.string();
          continue;
        case 12:
          if (tag !== 98) {
            break;
          }

          message.vehicleImgFrontsight = reader.string();
          continue;
        case 13:
          if (tag !== 106) {
            break;
          }

          message.vehicleImgBacksight = reader.string();
          continue;
        case 14:
          if (tag !== 114) {
            break;
          }

          message.vehicleImgLeftsight = reader.string();
          continue;
        case 15:
          if (tag !== 122) {
            break;
          }

          message.vehicleImgRightsight = reader.string();
          continue;
        case 16:
          if (tag !== 130) {
            break;
          }

          message.currentAddress = reader.string();
          continue;
        case 17:
          if (tag !== 138) {
            break;
          }

          message.vehicleRegistrationFrontsight = reader.string();
          continue;
        case 18:
          if (tag !== 146) {
            break;
          }

          message.vehicleRegistrationBacksight = reader.string();
          continue;
        case 19:
          if (tag !== 154) {
            break;
          }

          message.vehicleInsuranceFrontsight = reader.string();
          continue;
        case 20:
          if (tag !== 162) {
            break;
          }

          message.vehicleInsuranceBacksight = reader.string();
          continue;
        case 21:
          if (tag !== 170) {
            break;
          }

          message.identityDate = reader.string();
          continue;
        case 22:
          if (tag !== 178) {
            break;
          }

          message.identityLocation = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ServiceApprovalInformation {
    return {
      id: isSet(object.id) ? globalThis.String(object.id) : "",
      supplyID: isSet(object.supplyID) ? globalThis.String(object.supplyID) : "",
      serviceID: isSet(object.serviceID) ? globalThis.String(object.serviceID) : "",
      vehicleID: isSet(object.vehicleID) ? globalThis.String(object.vehicleID) : "",
      status: isSet(object.status) ? globalThis.String(object.status) : "",
      createdDate: isSet(object.createdDate) ? globalThis.String(object.createdDate) : "",
      driverLicenseFrontsight: isSet(object.driverLicenseFrontsight)
        ? globalThis.String(object.driverLicenseFrontsight)
        : "",
      driverLicenseBacksight: isSet(object.driverLicenseBacksight)
        ? globalThis.String(object.driverLicenseBacksight)
        : "",
      personalImg: isSet(object.personalImg) ? globalThis.String(object.personalImg) : "",
      identityImgFrontsight: isSet(object.identityImgFrontsight) ? globalThis.String(object.identityImgFrontsight) : "",
      identityImgBacksight: isSet(object.identityImgBacksight) ? globalThis.String(object.identityImgBacksight) : "",
      vehicleImgFrontsight: isSet(object.vehicleImgFrontsight) ? globalThis.String(object.vehicleImgFrontsight) : "",
      vehicleImgBacksight: isSet(object.vehicleImgBacksight) ? globalThis.String(object.vehicleImgBacksight) : "",
      vehicleImgLeftsight: isSet(object.vehicleImgLeftsight) ? globalThis.String(object.vehicleImgLeftsight) : "",
      vehicleImgRightsight: isSet(object.vehicleImgRightsight) ? globalThis.String(object.vehicleImgRightsight) : "",
      currentAddress: isSet(object.currentAddress) ? globalThis.String(object.currentAddress) : "",
      vehicleRegistrationFrontsight: isSet(object.vehicleRegistrationFrontsight)
        ? globalThis.String(object.vehicleRegistrationFrontsight)
        : "",
      vehicleRegistrationBacksight: isSet(object.vehicleRegistrationBacksight)
        ? globalThis.String(object.vehicleRegistrationBacksight)
        : "",
      vehicleInsuranceFrontsight: isSet(object.vehicleInsuranceFrontsight)
        ? globalThis.String(object.vehicleInsuranceFrontsight)
        : "",
      vehicleInsuranceBacksight: isSet(object.vehicleInsuranceBacksight)
        ? globalThis.String(object.vehicleInsuranceBacksight)
        : "",
      identityDate: isSet(object.identityDate) ? globalThis.String(object.identityDate) : "",
      identityLocation: isSet(object.identityLocation) ? globalThis.String(object.identityLocation) : "",
    };
  },

  toJSON(message: ServiceApprovalInformation): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    if (message.supplyID !== "") {
      obj.supplyID = message.supplyID;
    }
    if (message.serviceID !== "") {
      obj.serviceID = message.serviceID;
    }
    if (message.vehicleID !== "") {
      obj.vehicleID = message.vehicleID;
    }
    if (message.status !== "") {
      obj.status = message.status;
    }
    if (message.createdDate !== "") {
      obj.createdDate = message.createdDate;
    }
    if (message.driverLicenseFrontsight !== "") {
      obj.driverLicenseFrontsight = message.driverLicenseFrontsight;
    }
    if (message.driverLicenseBacksight !== "") {
      obj.driverLicenseBacksight = message.driverLicenseBacksight;
    }
    if (message.personalImg !== "") {
      obj.personalImg = message.personalImg;
    }
    if (message.identityImgFrontsight !== "") {
      obj.identityImgFrontsight = message.identityImgFrontsight;
    }
    if (message.identityImgBacksight !== "") {
      obj.identityImgBacksight = message.identityImgBacksight;
    }
    if (message.vehicleImgFrontsight !== "") {
      obj.vehicleImgFrontsight = message.vehicleImgFrontsight;
    }
    if (message.vehicleImgBacksight !== "") {
      obj.vehicleImgBacksight = message.vehicleImgBacksight;
    }
    if (message.vehicleImgLeftsight !== "") {
      obj.vehicleImgLeftsight = message.vehicleImgLeftsight;
    }
    if (message.vehicleImgRightsight !== "") {
      obj.vehicleImgRightsight = message.vehicleImgRightsight;
    }
    if (message.currentAddress !== "") {
      obj.currentAddress = message.currentAddress;
    }
    if (message.vehicleRegistrationFrontsight !== "") {
      obj.vehicleRegistrationFrontsight = message.vehicleRegistrationFrontsight;
    }
    if (message.vehicleRegistrationBacksight !== "") {
      obj.vehicleRegistrationBacksight = message.vehicleRegistrationBacksight;
    }
    if (message.vehicleInsuranceFrontsight !== "") {
      obj.vehicleInsuranceFrontsight = message.vehicleInsuranceFrontsight;
    }
    if (message.vehicleInsuranceBacksight !== "") {
      obj.vehicleInsuranceBacksight = message.vehicleInsuranceBacksight;
    }
    if (message.identityDate !== "") {
      obj.identityDate = message.identityDate;
    }
    if (message.identityLocation !== "") {
      obj.identityLocation = message.identityLocation;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ServiceApprovalInformation>, I>>(base?: I): ServiceApprovalInformation {
    return ServiceApprovalInformation.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ServiceApprovalInformation>, I>>(object: I): ServiceApprovalInformation {
    const message = createBaseServiceApprovalInformation();
    message.id = object.id ?? "";
    message.supplyID = object.supplyID ?? "";
    message.serviceID = object.serviceID ?? "";
    message.vehicleID = object.vehicleID ?? "";
    message.status = object.status ?? "";
    message.createdDate = object.createdDate ?? "";
    message.driverLicenseFrontsight = object.driverLicenseFrontsight ?? "";
    message.driverLicenseBacksight = object.driverLicenseBacksight ?? "";
    message.personalImg = object.personalImg ?? "";
    message.identityImgFrontsight = object.identityImgFrontsight ?? "";
    message.identityImgBacksight = object.identityImgBacksight ?? "";
    message.vehicleImgFrontsight = object.vehicleImgFrontsight ?? "";
    message.vehicleImgBacksight = object.vehicleImgBacksight ?? "";
    message.vehicleImgLeftsight = object.vehicleImgLeftsight ?? "";
    message.vehicleImgRightsight = object.vehicleImgRightsight ?? "";
    message.currentAddress = object.currentAddress ?? "";
    message.vehicleRegistrationFrontsight = object.vehicleRegistrationFrontsight ?? "";
    message.vehicleRegistrationBacksight = object.vehicleRegistrationBacksight ?? "";
    message.vehicleInsuranceFrontsight = object.vehicleInsuranceFrontsight ?? "";
    message.vehicleInsuranceBacksight = object.vehicleInsuranceBacksight ?? "";
    message.identityDate = object.identityDate ?? "";
    message.identityLocation = object.identityLocation ?? "";
    return message;
  },
};

function createBaseServiceInformation(): ServiceInformation {
  return { id: "", name: "", description: "", basePrice: 0 };
}

export const ServiceInformation = {
  encode(message: ServiceInformation, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    if (message.name !== "") {
      writer.uint32(18).string(message.name);
    }
    if (message.description !== "") {
      writer.uint32(26).string(message.description);
    }
    if (message.basePrice !== 0) {
      writer.uint32(33).double(message.basePrice);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ServiceInformation {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseServiceInformation();
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

          message.name = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.description = reader.string();
          continue;
        case 4:
          if (tag !== 33) {
            break;
          }

          message.basePrice = reader.double();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ServiceInformation {
    return {
      id: isSet(object.id) ? globalThis.String(object.id) : "",
      name: isSet(object.name) ? globalThis.String(object.name) : "",
      description: isSet(object.description) ? globalThis.String(object.description) : "",
      basePrice: isSet(object.basePrice) ? globalThis.Number(object.basePrice) : 0,
    };
  },

  toJSON(message: ServiceInformation): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    if (message.name !== "") {
      obj.name = message.name;
    }
    if (message.description !== "") {
      obj.description = message.description;
    }
    if (message.basePrice !== 0) {
      obj.basePrice = message.basePrice;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ServiceInformation>, I>>(base?: I): ServiceInformation {
    return ServiceInformation.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ServiceInformation>, I>>(object: I): ServiceInformation {
    const message = createBaseServiceInformation();
    message.id = object.id ?? "";
    message.name = object.name ?? "";
    message.description = object.description ?? "";
    message.basePrice = object.basePrice ?? 0;
    return message;
  },
};

function createBaseReqCreateVehicleData(): ReqCreateVehicleData {
  return { supplyID: "", name: "", identityNumber: "", color: "", brand: "" };
}

export const ReqCreateVehicleData = {
  encode(message: ReqCreateVehicleData, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.supplyID !== "") {
      writer.uint32(10).string(message.supplyID);
    }
    if (message.name !== "") {
      writer.uint32(18).string(message.name);
    }
    if (message.identityNumber !== "") {
      writer.uint32(26).string(message.identityNumber);
    }
    if (message.color !== "") {
      writer.uint32(34).string(message.color);
    }
    if (message.brand !== "") {
      writer.uint32(42).string(message.brand);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ReqCreateVehicleData {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseReqCreateVehicleData();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.supplyID = reader.string();
          continue;
        case 2:
          if (tag !== 18) {
            break;
          }

          message.name = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.identityNumber = reader.string();
          continue;
        case 4:
          if (tag !== 34) {
            break;
          }

          message.color = reader.string();
          continue;
        case 5:
          if (tag !== 42) {
            break;
          }

          message.brand = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ReqCreateVehicleData {
    return {
      supplyID: isSet(object.supplyID) ? globalThis.String(object.supplyID) : "",
      name: isSet(object.name) ? globalThis.String(object.name) : "",
      identityNumber: isSet(object.identityNumber) ? globalThis.String(object.identityNumber) : "",
      color: isSet(object.color) ? globalThis.String(object.color) : "",
      brand: isSet(object.brand) ? globalThis.String(object.brand) : "",
    };
  },

  toJSON(message: ReqCreateVehicleData): unknown {
    const obj: any = {};
    if (message.supplyID !== "") {
      obj.supplyID = message.supplyID;
    }
    if (message.name !== "") {
      obj.name = message.name;
    }
    if (message.identityNumber !== "") {
      obj.identityNumber = message.identityNumber;
    }
    if (message.color !== "") {
      obj.color = message.color;
    }
    if (message.brand !== "") {
      obj.brand = message.brand;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ReqCreateVehicleData>, I>>(base?: I): ReqCreateVehicleData {
    return ReqCreateVehicleData.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ReqCreateVehicleData>, I>>(object: I): ReqCreateVehicleData {
    const message = createBaseReqCreateVehicleData();
    message.supplyID = object.supplyID ?? "";
    message.name = object.name ?? "";
    message.identityNumber = object.identityNumber ?? "";
    message.color = object.color ?? "";
    message.brand = object.brand ?? "";
    return message;
  },
};

function createBaseVehicleInformation(): VehicleInformation {
  return { id: "", name: "", identityNumber: "", color: "", brand: "" };
}

export const VehicleInformation = {
  encode(message: VehicleInformation, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.id !== "") {
      writer.uint32(10).string(message.id);
    }
    if (message.name !== "") {
      writer.uint32(18).string(message.name);
    }
    if (message.identityNumber !== "") {
      writer.uint32(26).string(message.identityNumber);
    }
    if (message.color !== "") {
      writer.uint32(34).string(message.color);
    }
    if (message.brand !== "") {
      writer.uint32(42).string(message.brand);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): VehicleInformation {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseVehicleInformation();
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

          message.name = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.identityNumber = reader.string();
          continue;
        case 4:
          if (tag !== 34) {
            break;
          }

          message.color = reader.string();
          continue;
        case 5:
          if (tag !== 42) {
            break;
          }

          message.brand = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): VehicleInformation {
    return {
      id: isSet(object.id) ? globalThis.String(object.id) : "",
      name: isSet(object.name) ? globalThis.String(object.name) : "",
      identityNumber: isSet(object.identityNumber) ? globalThis.String(object.identityNumber) : "",
      color: isSet(object.color) ? globalThis.String(object.color) : "",
      brand: isSet(object.brand) ? globalThis.String(object.brand) : "",
    };
  },

  toJSON(message: VehicleInformation): unknown {
    const obj: any = {};
    if (message.id !== "") {
      obj.id = message.id;
    }
    if (message.name !== "") {
      obj.name = message.name;
    }
    if (message.identityNumber !== "") {
      obj.identityNumber = message.identityNumber;
    }
    if (message.color !== "") {
      obj.color = message.color;
    }
    if (message.brand !== "") {
      obj.brand = message.brand;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<VehicleInformation>, I>>(base?: I): VehicleInformation {
    return VehicleInformation.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<VehicleInformation>, I>>(object: I): VehicleInformation {
    const message = createBaseVehicleInformation();
    message.id = object.id ?? "";
    message.name = object.name ?? "";
    message.identityNumber = object.identityNumber ?? "";
    message.color = object.color ?? "";
    message.brand = object.brand ?? "";
    return message;
  },
};

function createBaseServiceApprovalList(): ServiceApprovalList {
  return { serviceApprovals: [] };
}

export const ServiceApprovalList = {
  encode(message: ServiceApprovalList, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    for (const v of message.serviceApprovals) {
      ServiceApprovalInformation.encode(v!, writer.uint32(10).fork()).ldelim();
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ServiceApprovalList {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseServiceApprovalList();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.serviceApprovals.push(ServiceApprovalInformation.decode(reader, reader.uint32()));
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ServiceApprovalList {
    return {
      serviceApprovals: globalThis.Array.isArray(object?.serviceApprovals)
        ? object.serviceApprovals.map((e: any) => ServiceApprovalInformation.fromJSON(e))
        : [],
    };
  },

  toJSON(message: ServiceApprovalList): unknown {
    const obj: any = {};
    if (message.serviceApprovals?.length) {
      obj.serviceApprovals = message.serviceApprovals.map((e) => ServiceApprovalInformation.toJSON(e));
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ServiceApprovalList>, I>>(base?: I): ServiceApprovalList {
    return ServiceApprovalList.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ServiceApprovalList>, I>>(object: I): ServiceApprovalList {
    const message = createBaseServiceApprovalList();
    message.serviceApprovals = object.serviceApprovals?.map((e) => ServiceApprovalInformation.fromPartial(e)) || [];
    return message;
  },
};

function createBaseServiceList(): ServiceList {
  return { services: [] };
}

export const ServiceList = {
  encode(message: ServiceList, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    for (const v of message.services) {
      ServiceInformation.encode(v!, writer.uint32(10).fork()).ldelim();
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ServiceList {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseServiceList();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.services.push(ServiceInformation.decode(reader, reader.uint32()));
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): ServiceList {
    return {
      services: globalThis.Array.isArray(object?.services)
        ? object.services.map((e: any) => ServiceInformation.fromJSON(e))
        : [],
    };
  },

  toJSON(message: ServiceList): unknown {
    const obj: any = {};
    if (message.services?.length) {
      obj.services = message.services.map((e) => ServiceInformation.toJSON(e));
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<ServiceList>, I>>(base?: I): ServiceList {
    return ServiceList.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ServiceList>, I>>(object: I): ServiceList {
    const message = createBaseServiceList();
    message.services = object.services?.map((e) => ServiceInformation.fromPartial(e)) || [];
    return message;
  },
};

function createBaseServiceApprovalEmptyRequest(): ServiceApprovalEmptyRequest {
  return {};
}

export const ServiceApprovalEmptyRequest = {
  encode(_: ServiceApprovalEmptyRequest, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): ServiceApprovalEmptyRequest {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseServiceApprovalEmptyRequest();
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

  fromJSON(_: any): ServiceApprovalEmptyRequest {
    return {};
  },

  toJSON(_: ServiceApprovalEmptyRequest): unknown {
    const obj: any = {};
    return obj;
  },

  create<I extends Exact<DeepPartial<ServiceApprovalEmptyRequest>, I>>(base?: I): ServiceApprovalEmptyRequest {
    return ServiceApprovalEmptyRequest.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<ServiceApprovalEmptyRequest>, I>>(_: I): ServiceApprovalEmptyRequest {
    const message = createBaseServiceApprovalEmptyRequest();
    return message;
  },
};

export type AdminService = typeof AdminService;
export const AdminService = {
  getServices: {
    path: "/Admin/getServices",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: ServiceApprovalEmptyRequest) =>
      Buffer.from(ServiceApprovalEmptyRequest.encode(value).finish()),
    requestDeserialize: (value: Buffer) => ServiceApprovalEmptyRequest.decode(value),
    responseSerialize: (value: ServiceList) => Buffer.from(ServiceList.encode(value).finish()),
    responseDeserialize: (value: Buffer) => ServiceList.decode(value),
  },
  createServiceApproval: {
    path: "/Admin/createServiceApproval",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: ReqCreateData) => Buffer.from(ReqCreateData.encode(value).finish()),
    requestDeserialize: (value: Buffer) => ReqCreateData.decode(value),
    responseSerialize: (value: ServiceApprovalInformation) =>
      Buffer.from(ServiceApprovalInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => ServiceApprovalInformation.decode(value),
  },
  createVehicleInformation: {
    path: "/Admin/createVehicleInformation",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: ReqCreateVehicleData) => Buffer.from(ReqCreateVehicleData.encode(value).finish()),
    requestDeserialize: (value: Buffer) => ReqCreateVehicleData.decode(value),
    responseSerialize: (value: ServiceApprovalInformation) =>
      Buffer.from(ServiceApprovalInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => ServiceApprovalInformation.decode(value),
  },
  updateServiceApproval: {
    path: "/Admin/updateServiceApproval",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: ReqUpdateData) => Buffer.from(ReqUpdateData.encode(value).finish()),
    requestDeserialize: (value: Buffer) => ReqUpdateData.decode(value),
    responseSerialize: (value: ServiceApprovalInformation) =>
      Buffer.from(ServiceApprovalInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => ServiceApprovalInformation.decode(value),
  },
  updateIdentityInfo: {
    path: "/Admin/updateIdentityInfo",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: ReqUpdateIdentityInfo) => Buffer.from(ReqUpdateIdentityInfo.encode(value).finish()),
    requestDeserialize: (value: Buffer) => ReqUpdateIdentityInfo.decode(value),
    responseSerialize: (value: ServiceApprovalInformation) =>
      Buffer.from(ServiceApprovalInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => ServiceApprovalInformation.decode(value),
  },
  findApprovalById: {
    path: "/Admin/findApprovalById",
    requestStream: false,
    responseStream: false,
    requestSerialize: (value: ReqCreateData) => Buffer.from(ReqCreateData.encode(value).finish()),
    requestDeserialize: (value: Buffer) => ReqCreateData.decode(value),
    responseSerialize: (value: ServiceApprovalInformation) =>
      Buffer.from(ServiceApprovalInformation.encode(value).finish()),
    responseDeserialize: (value: Buffer) => ServiceApprovalInformation.decode(value),
  },
} as const;

export interface AdminServer extends UntypedServiceImplementation {
  getServices: handleUnaryCall<ServiceApprovalEmptyRequest, ServiceList>;
  createServiceApproval: handleUnaryCall<ReqCreateData, ServiceApprovalInformation>;
  createVehicleInformation: handleUnaryCall<ReqCreateVehicleData, ServiceApprovalInformation>;
  updateServiceApproval: handleUnaryCall<ReqUpdateData, ServiceApprovalInformation>;
  updateIdentityInfo: handleUnaryCall<ReqUpdateIdentityInfo, ServiceApprovalInformation>;
  findApprovalById: handleUnaryCall<ReqCreateData, ServiceApprovalInformation>;
}

export interface AdminClient extends Client {
  getServices(
    request: ServiceApprovalEmptyRequest,
    callback: (error: ServiceError | null, response: ServiceList) => void,
  ): ClientUnaryCall;
  getServices(
    request: ServiceApprovalEmptyRequest,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: ServiceList) => void,
  ): ClientUnaryCall;
  getServices(
    request: ServiceApprovalEmptyRequest,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: ServiceList) => void,
  ): ClientUnaryCall;
  createServiceApproval(
    request: ReqCreateData,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  createServiceApproval(
    request: ReqCreateData,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  createServiceApproval(
    request: ReqCreateData,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  createVehicleInformation(
    request: ReqCreateVehicleData,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  createVehicleInformation(
    request: ReqCreateVehicleData,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  createVehicleInformation(
    request: ReqCreateVehicleData,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  updateServiceApproval(
    request: ReqUpdateData,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  updateServiceApproval(
    request: ReqUpdateData,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  updateServiceApproval(
    request: ReqUpdateData,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  updateIdentityInfo(
    request: ReqUpdateIdentityInfo,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  updateIdentityInfo(
    request: ReqUpdateIdentityInfo,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  updateIdentityInfo(
    request: ReqUpdateIdentityInfo,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  findApprovalById(
    request: ReqCreateData,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  findApprovalById(
    request: ReqCreateData,
    metadata: Metadata,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
  findApprovalById(
    request: ReqCreateData,
    metadata: Metadata,
    options: Partial<CallOptions>,
    callback: (error: ServiceError | null, response: ServiceApprovalInformation) => void,
  ): ClientUnaryCall;
}

export const AdminClient = makeGenericClientConstructor(AdminService, "Admin") as unknown as {
  new (address: string, credentials: ChannelCredentials, options?: Partial<ClientOptions>): AdminClient;
  service: typeof AdminService;
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
