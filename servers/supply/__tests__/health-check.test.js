import server from '../dist/server.js'
import supertest from 'supertest'
const requestWithSupertest = supertest(server)

describe('Health check supply server live', () => {
    it('GET /status should status 200 - OK, message: server is running ...', async () => {
        const res = await requestWithSupertest.get('/status')

        expect(res.status).toEqual(200)

        expect(res.type).toEqual(expect.stringContaining('json'))

        expect(res.body).toHaveProperty('server', 'KabGo Supply')
        expect(res.body).toHaveProperty('status', '200 - OK')
        expect(res.body).toHaveProperty('message', 'Server is running ...')
    })
})
