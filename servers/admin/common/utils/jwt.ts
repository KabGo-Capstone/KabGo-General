import * as jwt from 'jsonwebtoken'

interface IJWT {
    createToken(payload: any, options?: jwt.SignOptions): Promise<any>
    verifyToken(token: string, options?: jwt.VerifyOptions): Promise<any>
}

export class JsonWebToken implements IJWT {
    private readonly secret: string

    constructor(secret?: string) {
        this.secret =
            secret ??
            (process.env.JWT_SECRET as string) ??
            'AWA-EXAMPLE-Secret-152421'
    }

    public async createToken(
        payload: string | object | Buffer,
        options: jwt.SignOptions
    ): Promise<any> {
        return jwt.sign(payload, this.secret, options)
    }

    public async verifyToken(
        token: string,
        options?: jwt.VerifyOptions
    ): Promise<any> {
        return jwt.verify(token, this.secret, options)
    }
}

const Jwt = new JsonWebToken()

export default Jwt
