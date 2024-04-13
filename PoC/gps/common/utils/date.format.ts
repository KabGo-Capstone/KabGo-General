const getFormatDateTime = (): string => {
    const dateTime = new Date()
        .toLocaleString('en', { timeZone: 'Asia/Ho_Chi_Minh' })
        .split(', ')
    const date = dateTime[0].split('/')
    const [time, time12h] = dateTime[1].split(' ')

    const [month, day, year] = date
    const [hour, minute] = time.split(':')

    const formatDateTime =
        [day, month, year].join('/') +
        ' - ' +
        [hour, minute].join(':') +
        ' ' +
        time12h

    return formatDateTime
}

export default getFormatDateTime
