import { Server, ServerCredentials } from '@grpc/grpc-js'
import chalk from 'chalk'

import { CustomerInfomations } from '../protos/customers.proto'
import Logger from '../utils/logger'
import { CustomerInfomationsService } from '../../../grpc/proto_pb/demand/demand_grpc_pb'

class GrpcServer {
    private static instance: GrpcServer
    private server: Server

    private constructor() {
        this.server = new Server()
        this.loadProtos()
    }

    public static getInstance(): GrpcServer {
        return GrpcServer.instance ?? (GrpcServer.instance = new GrpcServer())
    }

    private loadProtos() {
        this.server.addService(
            CustomerInfomationsService,
            new CustomerInfomations()
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
                        `gRPC server is running on port ${chalk.cyan(process.env.gRPC_PORT ?? 50052)}`
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
