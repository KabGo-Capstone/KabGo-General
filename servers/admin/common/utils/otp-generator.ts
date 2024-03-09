import { generate } from 'otp-generator'
// options for otp-generator
export interface Options {
    digits?: boolean
    lowerCaseAlphabets?: boolean
    upperCaseAlphabets?: boolean
    specialChars?: boolean
}

export default class OTPGenerator {
    private readonly length: number
    private readonly options: Options

    constructor(options?: Options, length: number = 6) {
        this.length = length ?? 6
        this.options = options ?? {
            digits: true,
            lowerCaseAlphabets: false,
            upperCaseAlphabets: false,
            specialChars: false,
        }
    }

    public generate() {
        return generate(this.length, this.options)
    }
}
