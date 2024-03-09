import { Router } from 'express'

interface IController {
    readonly path: string
    readonly router: Router
}

export default IController
