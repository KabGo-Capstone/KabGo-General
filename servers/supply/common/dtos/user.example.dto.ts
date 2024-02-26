import { IsString, IsNotEmpty } from 'class-validator'
import { IUser } from '../models/user.example.model'

class UserDTO {
    @IsNotEmpty({ message: 'Email is required' })
    @IsString({ message: 'Email must be a string' })
    public email!: string

    @IsNotEmpty({ message: 'Password is required' })
    @IsString({ message: 'Password must be a string' })
    public password!: string

    @IsNotEmpty({ message: 'Lastname is required' })
    @IsString({ message: 'Lastname must be a string' })
    public lastname!: string

    @IsNotEmpty({ message: 'Firstname is required' })
    @IsString({ message: 'Firstname must be a string' })
    public firstname!: string

    constructor(obj: IUser) {
        Object.assign(this, obj)
    }
}

export default UserDTO
