import { Transporter, createTransport } from 'nodemailer'
import Mail from 'nodemailer/lib/mailer'
import SMTPTransport from 'nodemailer/lib/smtp-transport'

class MailerBuilder {
    private transporterOptions: SMTPTransport.Options
    private from: string

    constructor(transporterOptions?: SMTPTransport.Options, from?: string) {
        this.transporterOptions = transporterOptions ?? {
            service: process.env.MAILER_SERVICE,
            secure: true,
            auth: {
                user: process.env.MAILER_USER,
                pass: process.env.MAILER_PASS,
            },
        }

        this.from = from ?? (process.env.MAILER_FROM as string)
    }

    public withTransporter(transporterOptions: SMTPTransport.Options) {
        this.transporterOptions = transporterOptions
        return this
    }

    public withFrom(from: string) {
        this.from = from
        return this
    }

    public build() {
        return new Mailer(this.transporterOptions, this.from)
    }
}

export class Mailer {
    public transporter: Transporter
    public from: string

    constructor(transporterOptions: SMTPTransport.Options, from: string) {
        this.transporter = createTransport(transporterOptions)
        this.from = from
    }

    public static default(): Mailer {
        return this.builder().build()
    }

    public static builder(): MailerBuilder {
        return new MailerBuilder()
    }

    public async sendMail(mail: Mail.Options): Promise<any> {
        try {
            return await this.transporter.sendMail({
                from: this.from,
                ...mail,
            })
        } catch (error) {
            throw new Error(
                `An error occurred while sending the email. ${error}`
            )
        }
    }
}

const GMailer: Mailer = Mailer.default()

export default GMailer
