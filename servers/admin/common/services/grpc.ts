import { Server, ServerCredentials } from '@grpc/grpc-js'
import chalk from 'chalk'

import Logger from '../utils/logger'

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
        // this.server.addService(
        //     CustomerInfomationsService,
        //     new CustomerInfomations()
        // )
    }

    public start() {
        const credentials = ServerCredentials.createInsecure()

        this.server.bindAsync(
            `0.0.0.0:${process.env.gRPC_PORT ?? 50053}`,
            credentials,
            () => {
                Logger.info(
                    chalk.green(
                        `gRPC server is running on port ${chalk.cyan(process.env.gRPC_PORT ?? 50053)}`
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
