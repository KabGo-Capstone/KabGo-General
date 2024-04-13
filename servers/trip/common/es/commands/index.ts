import { TripCreateCommand } from './trip-create.command'
import { DriverLocateCommand } from './driver-locate.command'
import { DriverComeCommand } from './driver-come.command'
import { TripStartCommand } from './trip-start.command'
import { TripFinishCommand } from './trip-finish.command'
import { TripCancelCommand } from './trip-cancel.command'
import { DriverAcceptCommand } from './driver-accept.command'
import { DriverCancelCommand } from './driver-cancel.command'

export type TripCommand =
    | TripCreateCommand
    | DriverLocateCommand
    | DriverAcceptCommand
    | DriverCancelCommand
    | DriverComeCommand
    | TripStartCommand
    | TripFinishCommand
    | TripCancelCommand
