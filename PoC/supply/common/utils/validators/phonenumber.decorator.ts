import {
    ValidatorConstraint,
    ValidatorConstraintInterface,
    ValidationArguments,
    ValidationOptions,
    registerDecorator,
} from 'class-validator'

@ValidatorConstraint({ name: 'isPhoneNumber', async: false })
class IsPhoneNumberConstraint implements ValidatorConstraintInterface {
    validate(value: string, args: ValidationArguments) {
        return value
            ? /(03|05|07|08|09|01[2|6|8|9])+(\d{8})\b/.test(value)
            : true
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
