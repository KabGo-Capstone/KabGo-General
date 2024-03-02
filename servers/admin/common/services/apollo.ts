import { ApolloServer } from '@apollo/server'
// import { startStandaloneServer } from '@apollo/server/standalone'
import { ApolloServerPluginDrainHttpServer } from '@apollo/server/plugin/drainHttpServer'
import dummyData from '../dummy_data/dummy_data'
import Logger from '../utils/logger'
import chalk from 'chalk'
import { Server } from 'http'

const typeDefs = `#graphql.type
    type Service {
        id: ID!,
        name: String!, 
        description: String!,
        basePrice: Int!,
        serviceApprovals: [ServiceApproval!]
    } 
    type Vehicle {
        id: ID!,
        name: String!, 
        identityNumber: String!, 
        color: String!, 
        brand: String!, 
    },
    type Supply {
      id: ID!,
      firstName: String!,
      lastName: String!,
      password: String!,
      dob: String!,
      gender: String!,
      address: String!,  
      verified: Boolean!,
      avatar: String!,
      email: String!
      serviceApprovals: [ServiceApproval!]
    },
    type ServiceApproval {
        id: ID!,
        supply: Supply!,
        service: Service!,
        vehicle: Vehicle!,
        status: String!,
        createdDate: String!, 
        driverLicense: String!,
        personalImg: String!,
        identityImg: String!,
        vehicleImg: String!,
        currentAddress: String!,  
    }
    type Query {
        services: [Service],
        service(id: ID): Service,
        vehicles: [Vehicle],
        vehicle(id: ID): Vehicle,
        supplies: [Supply],
        supply(id: ID): Supply,
        serviceApprovals: [ServiceApproval],
        serviceApproval(id: ID): ServiceApproval
    }
    type Mutation {
        approveDriver(service_approval_id: ID!): ServiceApproval,
        disApproveDriver(service_approval_id: ID!): ServiceApproval,
        deleteServiceApproval(service_approval_id: ID!): [ServiceApproval!]
    }
`

const resolvers = {
    Query: {
        services() {
            return dummyData.services
        },
        vehicles() {
            return dummyData.vehicles
        },
        supplies() {
            return dummyData.supplies
        },
        serviceApprovals() {
            return dummyData.serviceApprovals
        },
    },
    ServiceApproval: {
        supply(parent: any, args: any) {
            console.log('hit here...');
            return dummyData.supplies.find(
                (supply) => supply.id === parent.supplyID
            )
        },
        service(parent: any, args: any) {
            return dummyData.services.find(
                (service) => service.id === parent.serviceID
            )
        },
        vehicle(parent: any, args: any) {
            return dummyData.vehicles.find(
                (vehicle) => vehicle.id === parent.vehicleID
            )
        },
    },
    Mutation: {
        approveDriver(_: any, args: any) {
            let foundSupplyId: any = null
            let updatedServiceApproval = null
            dummyData.serviceApprovals = dummyData.serviceApprovals.map(
                (serviceApproval) => {
                    if (
                        serviceApproval &&
                        serviceApproval.id === args.service_approval_id
                    ) {
                        foundSupplyId = serviceApproval.supplyID
                        updatedServiceApproval = {
                            ...serviceApproval,
                            status: 'approved',
                        }
                        return updatedServiceApproval
                    } else return serviceApproval
                }
            )
            dummyData.supplies = dummyData.supplies.map((supply) => {
                if (supply.id === foundSupplyId)
                    return { ...supply, verified: true }
                else return supply
            })
            return updatedServiceApproval
        },
        disApproveDriver(_: any, args: any) {
            let foundSupplyId: any = null
            let updatedServiceApproval = null
            dummyData.serviceApprovals = dummyData.serviceApprovals.map(
                (serviceApproval) => {
                    if (serviceApproval.id == args.service_approval_id) {
                        foundSupplyId = serviceApproval.supplyID
                        updatedServiceApproval = {
                            ...serviceApproval,
                            status: 'pending',
                        }
                        return updatedServiceApproval
                    } else return serviceApproval
                }
            )
            dummyData.supplies = dummyData.supplies.map((supply) => {
                if (supply.id === foundSupplyId)
                    return { ...supply, verified: false }
                else return supply
            })
            return updatedServiceApproval
        },
        deleteServiceApproval(_: any, args: any) {
            dummyData.serviceApprovals = dummyData.serviceApprovals.filter(
                (serviceApproval) =>
                    serviceApproval.id !== args.service_approval_id
            )
            return dummyData.serviceApprovals
        },
    },
}

class ApolloGraphQLServer {
    private static instance: ApolloGraphQLServer
    private server: ApolloServer
    private constructor(httpServer: Server) {
        this.server = new ApolloServer({
            // cors:   {
            //     origin: '*', // <- allow request from all domains
            //     credentials: true
            // },
            // typeDefs -- definitions of types of data
            typeDefs,
            // resolver functions determine how we respond to queries for different data on the graph
            resolvers,
            plugins: [ApolloServerPluginDrainHttpServer({ httpServer })],
        })
    }
    public static init(httpServer: Server): ApolloGraphQLServer {
        return (
            ApolloGraphQLServer.instance ??
            (ApolloGraphQLServer.instance = new ApolloGraphQLServer(httpServer))
        )
    }

    public async start() {
        // const { url } = await startStandaloneServer(this.server, {
        //     listen: {
        //         port: 4003,
        //     },
        // })
        await this.server.start()
        Logger.info(
            chalk.green(`Apollo GraphQL server is running on port ${chalk.cyan(5003)}`)
        )

        return this.server
    }
}

export default ApolloGraphQLServer
