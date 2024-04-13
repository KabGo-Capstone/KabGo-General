import express from 'express'
import {
    storeCheckpointInCollection,
    SubscriptionToAllWithMongoCheckpoints,
} from '../event-store/mongodb'
import { projectToTrip } from 'common/es/projections'

class Application {
    private app: express.Application

    constructor() {
        this.app = express()
    }

    setup() {
        this.app.use(express.json())
        this.app.use(express.urlencoded({ extended: true }))
    }

    listen(port: number) {
        const server = this.app.listen(port, async () => {
            try {
                await SubscriptionToAllWithMongoCheckpoints('sub_trips', [
                    storeCheckpointInCollection(projectToTrip),
                ])
            } catch (error) {
                console.log(error)
            }
            console.log(`Server is running on port ${port}`)
        })

        return this.app
    }
}

new Application().listen(4000)
