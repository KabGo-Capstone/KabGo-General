import path from 'path'
import DatauriParser from 'datauri/parser'
import multer, { Multer } from 'multer'
import { Request, Response, NextFunction } from 'express'
import cloudinary from './services/cloudinary'
import { UploadApiResponse } from 'cloudinary'

class MulterCloudinaryUploader {
    private allowedFileTypes: string[]
    private maxFileSize: number
    private upload: Multer

    constructor(allowedFileTypes: string[], maxFileSize: number) {
        this.allowedFileTypes = allowedFileTypes ?? [
            'jpg',
            'jpeg',
            'png',
            'gif',
        ]
        this.maxFileSize = maxFileSize ?? 5 * 1024 * 1024 // 5 MB

        const storage = multer.memoryStorage()

        this.upload = multer({
            storage: storage,
            fileFilter: this.fileFilter.bind(this),
            limits: { fileSize: this.maxFileSize },
        })
    }

    public single(fieldName: string) {
        return this.upload.single(fieldName)
    }

    public uploadCloud(folder: string = 'images') {
        return async (req: Request, res: Response, next: NextFunction) => {
            const fileStream = this.dataUri(req)

            if (req.file && fileStream) {
                const file = fileStream.content

                return cloudinary
                    .upload(file, {
                        folder: folder,
                        resource_type: 'auto',
                    })
                    .then((result: UploadApiResponse) => {
                        req.cloudinaryResult = result
                        next()
                    })
                    .catch((err) => next(err))
            }
            next()
        }
    }

    private dataUri(req: Request) {
        const dUri = new DatauriParser()
        return req.file
            ? dUri.format(
                  path.extname(req.file.originalname).toString(),
                  req.file.buffer
              )
            : null
    }

    private fileFilter(req: Request, file: any, callback: any) {
        const extname = file.originalname.toLowerCase().split('.').pop()

        if (this.allowedFileTypes.includes(extname)) {
            return callback(null, true)
        }

        return callback(new Error('Invalid file type'))
    }
}

export default MulterCloudinaryUploader
