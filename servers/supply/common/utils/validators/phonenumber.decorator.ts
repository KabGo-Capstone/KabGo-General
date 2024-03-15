import {
    ValidatorConstraint,
    ValidatorConstraintInterface,
    ValidationArguments,
    ValidationOptions,
    registerDecorator,
} from 'class-validator'
import { PHONENUMER_REGEX } from 'common/constants/regex'

@ValidatorConstraint({ name: 'isPhoneNumber', async: false })
class IsPhoneNumberConstraint implements ValidatorConstraintInterface {
    validate(value: string, args: ValidationArguments) {
        return value ? PHONENUMER_REGEX.test(value) : true
    }

    defaultMessage(args: ValidationArguments) {
        return 'Invalid phone number'
    }
}

export function IsPhoneNumber(validationOptions?: ValidationOptions) {
    return function (object: object, propertyName: string) {
        registerDecorator({
            name: 'isPhoneNumber',
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            constraints: [],
            validator: IsPhoneNumberConstraint,
        })
    }
}
