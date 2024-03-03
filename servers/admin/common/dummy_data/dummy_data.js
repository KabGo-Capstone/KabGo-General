// columns: 
// tên tài xế, dịch vụ, phương tiện (name), ngày, trạng thái
// actions:
// duyệt/hủy, xóa, xem chi tiết. Duyệt là thay đổi trạng thái thành "đã duyệt", hủy là thay đổi trạng thái thành "hủy"

export const services = [
    {
        id: '1',
        name: 'Xe máy',
        description: 'lorem ipsum',
        basePrice: 7000,
    },
    {
        id: '2',
        name: 'Ô tô 4 chỗ',
        description: 'lorem ipsum',
        basePrice: 10000,
    },
    {
        id: '3',
        name: 'Ô tô 7 chỗ',
        description: 'lorem ipsum',
        basePrice: 15000,
    },
];

export const vehicles = [
    {
        id: '1',
        name: 'Honda Air Blade 160/125',
        identityNumber: '59-Z499999',
        color: 'màu đen',
        brand: 'Honda',
    },
    {
        id: '2',
        name: 'Honda SH mode 125',
        identityNumber: '60-Z499999',
        color: 'màu đỏ',
        brand: 'Honda',
    },
    {
        id: '3',
        name: 'Toyota Vios',
        identityNumber: '61-Z499999',
        color: 'màu trắng',
        brand: 'Toyota',
    },
    {
        id: '4',
        name: 'Honda Civic',
        identityNumber: '62-Z499999',
        color: 'màu đen',
        brand: 'Honda',
    },   
    {
        id: '5',
        name: 'Vinfast Lux SA2.0',
        identityNumber: '63-Z499999',
        color: 'màu trắng',
        brand: 'VinFast',
    },
    {
        id: '6',
        name: 'Toyota Avanza Premio',
        identityNumber: '64-Z499999',
        color: 'màu trắng',
        brand: 'Toyota',
    },
    {
        id: '7',
        name: 'VinFast Fadil',
        identityNumber: '65-Z499999',
        color: 'màu đỏ',
        brand: 'VinFast',
    },
    {
        id: '8',
        name: 'Honda Brio',
        identityNumber: '66-Z499999',
        color: 'màu xanh',
        brand: 'Honda',
    }
];

export const serviceApprovals = [
    {
        id: '1',
        supplyID: '1',
        serviceID: '1',
        vehicleID: '1',
        status: 'pending',
        createdDate: '2024-01-01T17:35:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "25 Đào Trí, Phường Phú Thuận, Quận 7, TP.HCM",  
    },
    // Add more objects as needed
    {
        id: '2',
        supplyID: '2',
        serviceID: '2',
        vehicleID: '2',
        status: 'approved',
        createdDate: '2024-01-02T17:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "1647 Phạm Thế Hiển, Phường 6, Quận 8, TP.HCM",  
    },  
    {
        id: '3',
        supplyID: '3',
        serviceID: '3',
        vehicleID: '3',
        status: 'pending',
        createdDate: '2024-01-03T19:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "22 Huỳnh Đình Hai, Phường 24, Quận Bình Thạnh, TP.HCM",  
    },
    {
        id: '4',
        supplyID: '4',
        serviceID: '1',
        vehicleID: '4',
        status: 'approved',
        createdDate: '2024-01-04T18:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "22 Đường Số 10, Phường Thảo Điền, Quận 2, TP.HCM",  
    },
    {
        id: '5',
        supplyID: '5',
        serviceID: '3',
        vehicleID: '5',
        status: 'approved',
        createdDate: '2024-01-010T21:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "227 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
    },
    {
        id: '6',
        supplyID: '5',
        serviceID: '3',
        vehicleID: '6',
        status: 'approved',
        createdDate: '2024-01-010T21:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "229 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
    },
    {
        id: '7',
        supplyID: '5',
        serviceID: '2',
        vehicleID: '7',
        status: 'approved',
        createdDate: '2024-02-012T21:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "331 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
    },
    {
        id: '8',
        supplyID: '4',
        serviceID: '2',
        vehicleID: '8',
        status: 'approved',
        createdDate: '2024-04-016T22:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driverLicense: 'https://example.com',
        personalImg: 'https://example.com',
        identityImg: 'https://example.com',
        vehicleImg: 'https://example.com',
        currentAddress: "335 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
    },
];

export const supplies = [
    {
      id: '1',
      firstName: "Minh",
      lastName: "Nguyen",
      password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
      dob: "2002-10-15",
      gender: "male",
      address: "25 Đào Trí, Phường Phú Thuận, Quận 7, TP.HCM",  
      verified: false,
      avatar: 'https://example.com',
      email: "nguyenducminh@gmail.com"
    },
    {
      id: '2',
      firstName: "Khoa",
      lastName: "Nguyen",
      password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
      dob: "2002-4-14",
      gender: "male",
      address: "1647 Phạm Thế Hiển, Phường 6, Quận 8, TP.HCM",  
      verified: true,
      avatar: 'https://example.com',
      email: "khoanguyen@gmail.com"
    },  
    {
      id: '3',
      firstName: "Huy",
      lastName: "Nguyen",
      password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
      dob: "2002-10-15",
      gender: "male",
      address: "22 Huỳnh Đình Hai, Phường 24, Quận Bình Thạnh, TP.HCM",  
      verified: false,
      avatar: 'https://example.com',
      email: "huynguyen@gmail.com"
    },
    {
       id: '4',
       firstName: "Khang",
       lastName: "Dinh",
       password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
       dob: "2002-4-21",
       gender: "male",
       address: "22 Đường Số 10, Phường Thảo Điền, Quận 2, TP.HCM",  
       verified: true,
       avatar: 'https://example.com',
       email: "khangdinh@gmail.com"
    },
    {
       id: '5',
       firstName: "Thanh",
       lastName: "Bui",
       password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
       dob: "2002-10-15",
       gender: "male",
       address: "227 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
       verified: true,
       avatar: 'https://example.com',
       email: "thanhbui@gmail.com"
    },
];

export default { services, vehicles, serviceApprovals, supplies };