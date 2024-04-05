import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

export interface IUser {
    _id: mongoose.Types.ObjectId
    id?: string
    avatar?: string
    username?: string

    firstname: string
    lastname: string
    password: string
    email: string
    passwordChangedAt?: number
}

const UserSchema = new mongoose.Schema<IUser>(
    {
        username: { type: String },
        avatar: { type: String },
        firstname: { type: String, required: true },
        lastname: { type: String, required: true },
        password: { type: String, required: true },
        email: { type: String, required: true },
        passwordChangedAt: { type: Number },
    },
    {
        toJSON: {
            virtuals: true,
            versionKey: false,
        },
        toObject: {
            virtuals: true,
            versionKey: false,
        },
    }
)

UserSchema.virtual('id').get(function () {
    return this._id.toHexString()
})

UserSchema.pre('save', async function (next): Promise<void> {
    if (!this.isModified('password')) return next()

    const salt = await bcrypt.genSalt(
        (process.env.SALT_ROUNDS as any as number) || 12
    )
    this.password = await bcrypt.hash(this.password, salt)

    next()
})

UserSchema.pre('save', function (next) {
    if (!this.isModified('password') || this.isNew) return next()

    this.passwordChangedAt = Date.now() - 1000

    next()
})

const UserModel = mongoose.model<IUser>('User', UserSchema)

export default UserModel
