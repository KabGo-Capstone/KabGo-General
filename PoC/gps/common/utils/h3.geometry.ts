import { UNITS, getHexagonEdgeLengthAvg, gridDisk, latLngToCell } from 'h3-js'

export interface Coord {
    lat: number
    lng: number
}

class H3Geometry {
    static kRingIndexesEdge(
        searchLocation: Coord,
        searchRadiusKm: number,
        res = 9,
        pad = 0
    ) {
        const origin = latLngToCell(searchLocation.lat, searchLocation.lng, res) 
        const radius =
            Math.floor(
                searchRadiusKm / (getHexagonEdgeLengthAvg(res, UNITS.km) * 2)
            ) + pad // tính toán bán kính hình tròn

        return gridDisk(origin, radius) // trả về h3Index
    }

    static kRingResults(
        lookupMap: {
            [key: string]: any
        }, // h3Index for every single driver
        searchLocation: Coord, // gps of customer
        searchRadiusKm: number = 1.5 // radius of circle
    ) {
        const lookupIndexes = this.kRingIndexesEdge(
            searchLocation,
            searchRadiusKm
        )

        return lookupIndexes.reduce(
            (output: any[], h3Index) => [
                ...output,
                ...(lookupMap[h3Index] || []),
            ],
            []
        ) // tìm tất cả điểm trong phạm vi bán kính 
    }
}

export default H3Geometry
