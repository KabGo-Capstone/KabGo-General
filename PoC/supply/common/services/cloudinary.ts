import { ConfigOptions, UploadApiOptions, v2 as cloud } from 'cloudinary'
import { Request, Response, NextFunction } from 'express'

class Cloudinary {
    public config(options: ConfigOptions) {
        return (req: Request, res: Response, next: NextFunction) => {
            cloud.config(options)
            next()
        }
    }

    public upload = async (file: any, options?: UploadApiOptions) => {
        return await cloud.uploader.upload(file, options)
    }

    public destroy = async (publicId: string) => {
        return await cloud.uploader.destroy(publicId)
    }

    public delete = async (publicIds: string[]) => {
        return await cloud.api.delete_resources(publicIds, {
            type: 'upload',
            resource_type: 'raw',
        })
    }

    public crop = (id: string, h: number, w: number) => {
        return cloud.url(id, {
            height: h,
            width: w,
            crop: 'scale',
        })
    }
}

const cloudinary = new Cloudinary()

export default cloudinary
