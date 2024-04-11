import { ValidateIf } from 'class-validator'

export default function IsNotEqualTo(
    property: string,
    validationOptions?: { message?: string }
) {
    return function (object: Record<string, any>, propertyName: string) {
        ValidateIf((o) => o[property] !== o[propertyName], {
            message:
                validationOptions?.message ??
                `${propertyName} should not be equal to ${property}`,
        })(object, propertyName)
    }
}
