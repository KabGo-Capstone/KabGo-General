import { Server, ServerCredentials } from '@grpc/grpc-js'
import chalk from 'chalk'

import { DriverInfomations } from '../protos/drivers.proto'
import Logger from '../utils/logger'
import { DriverInfomationsService } from '../../../grpc/proto_pb/supply/supply_grpc_pb'

class GrpcServer {
    private static instance: GrpcServer
    private server: Server

    private constructor() {
        this.server = new Server()
        this.loadServices()
    }

    public static getInstance(): GrpcServer {
        return GrpcServer.instance ?? (GrpcServer.instance = new GrpcServer())
    }

    private loadServices() {
        this.server.addService(
            DriverInfomationsService,
            new DriverInfomations()
        )
    }

    public start() {
        const credentials = ServerCredentials.createInsecure()

        this.server.bindAsync(
            `0.0.0.0:${process.env.gRPC_PORT ?? 50051}`,
            credentials,
            () => {
                Logger.info(
                    chalk.green(
                        `gRPC server is running on port ${chalk.cyan(process.env.gRPC_PORT ?? 50051)}`
                    )
                )
            }
        )
    }

    public stop() {
        this.server.forceShutdown()
    }
}

const gRPC = GrpcServer.getInstance()

export default gRPC
