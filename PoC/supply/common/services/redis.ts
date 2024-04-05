import { RedisClientType, createClient } from 'redis'

class Redis {
    private static instance?: Redis
    private client: RedisClientType | null

    private constructor() {
        this.client = null
    }

    public static getInstance(): Redis {
        return this.instance ?? (this.instance = new this())
    }

    public async connect(uri: string) {
        try {
            this.client = createClient({
                url: uri,
            })

            await this.client.connect()
        } catch (error: any) {
            this.client = null
            throw error
        }
    }

    public getClient(): RedisClientType | null {
        return this.client
    }
}

const redis = Redis.getInstance()

export default redis
