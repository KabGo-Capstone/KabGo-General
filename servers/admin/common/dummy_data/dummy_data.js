// const moment = require('moment');
// columns: 
// tên tài xế, dịch vụ, phương tiện (name), ngày, trạng thái
// actions:
// duyệt/hủy, xóa, xem chi tiết. Duyệt là thay đổi trạng thái thành "đã duyệt", hủy là thay đổi trạng thái thành "hủy"

export let services = [
    {
        id: '1',
        name: 'Xe máy',
        description: 'lorem ipsum',
        base_price: 7000,
    },
    {
        id: '2',
        name: 'Ô tô 2-4 chỗ',
        description: 'lorem ipsum',
        base_price: 10000,
    },
    {
        id: '3',
        name: 'Ô tô 7 chỗ',
        description: 'lorem ipsum',
        base_price: 15000,
    },
];

export let vehicles = [
    {
        id: '1',
        name: 'Honda Air Blade 160/125',
        identity_number: '59-Z499999',
        color: 'màu đen',
        brand: 'Honda',
    },
    {
        id: '2',
        name: 'Honda SH mode 125',
        identity_number: '60-Z499999',
        color: 'màu đỏ',
        brand: 'Honda',
    },
    {
        id: '3',
        name: 'Toyota Vios',
        identity_number: '61-Z499999',
        color: 'màu trắng',
        brand: 'Toyota',
    },
    {
        id: '4',
        name: 'Honda Civic',
        identity_number: '62-Z499999',
        color: 'màu đen',
        brand: 'Honda',
    },   {
        id: '5',
        name: 'Vinfast Lux SA2.0',
        identity_number: '63-Z499999',
        color: 'màu trắng',
        brand: 'VinFast',
    }
];

export let serviceApprovals = [
    {
        id: '1',
        supply_id: '1',
        service_id: '1',
        vehicle_id: '1',
        status: 'pending',
        created_date: '2024-01-01T17:35:05.284Z', // Example date string with 'Z' at the end without zeros
        driver_license: 'https://example.com',
        personal_img: 'https://example.com',
        identity_img: 'https://example.com',
        vehicle_img: 'https://example.com',
        current_address: "25 Đào Trí, Phường Phú Thuận, Quận 7, TP.HCM",  
    },
    // Add more objects as needed
    {
        id: '2',
        supply_id: '2',
        service_id: '2',
        vehicle_id: '2',
        status: 'approved',
        created_date: '2024-01-02T17:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driver_license: 'https://example.com',
        personal_img: 'https://example.com',
        identity_img: 'https://example.com',
        vehicle_img: 'https://example.com',
        current_address: "1647 Phạm Thế Hiển, Phường 6, Quận 8, TP.HCM",  
    },  
    {
        id: '3',
        supply_id: '3',
        service_id: '3',
        vehicle_id: '3',
        status: 'pending',
        created_date: '2024-01-03T19:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driver_license: 'https://example.com',
        personal_img: 'https://example.com',
        identity_img: 'https://example.com',
        vehicle_img: 'https://example.com',
        current_address: "22 Huỳnh Đình Hai, Phường 24, Quận Bình Thạnh, TP.HCM",  
    },
    {
        id: '4',
        supply_id: '4',
        service_id: '4',
        vehicle_id: '4',
        status: 'approved',
        created_date: '2024-01-04T18:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driver_license: 'https://example.com',
        personal_img: 'https://example.com',
        identity_img: 'https://example.com',
        vehicle_img: 'https://example.com',
        current_address: "22 Đường Số 10, Phường Thảo Điền, Quận 2, TP.HCM",  
    },
    {
        id: '5',
        supply_id: '5',
        service_id: '5',
        vehicle_id: '5',
        status: 'approved',
        created_date: '2024-01-010T21:37:05.284Z', // Example date string with 'Z' at the end without zeros
        driver_license: 'https://example.com',
        personal_img: 'https://example.com',
        identity_img: 'https://example.com',
        vehicle_img: 'https://example.com',
        current_address: "227 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
    },
];

export let supplies = [
    {
      id: '1',
      first_name: "Minh",
      last_name: "Nguyen",
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
      first_name: "Khoa",
      last_name: "Nguyen",
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
      first_name: "Huy",
      last_name: "Nguyen",
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
       first_name: "Khang",
       last_name: "Dinh",
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
       first_name: "Thanh",
       last_name: "Bui",
       password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
       dob: "2002-10-15",
       gender: "male",
       address: "227 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
       verified: true,
       avatar: 'https://example.com',
       email: "thanhbui@gmail.com"
    },
];