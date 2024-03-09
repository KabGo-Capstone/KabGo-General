import {  gql} from '@apollo/client';

export const SERVICE_APPROVALS = gql`
query {
  serviceApprovals {
      id
      status
      createdDate
      driverLicense
      personalImg
      identityImg
      vehicleImg
      currentAddress
      supply {
          id
          firstName
          lastName
          password
          dob
          gender
          address
          verified
          avatar
          email
      }
      service {
          id
          name
          description
          basePrice
      }
      vehicle {
          id
          name
          identityNumber
          color
          brand
      }
  }
}
`

export const APPROVE_DRIVER = gql`
 mutation approveDriver($service_approval_id: ID!) {
    approveDriver(service_approval_id: $service_approval_id) {
        id,
        status,
        createdDate,
        driverLicense,
        personalImg,
        identityImg,
        vehicleImg,
        currentAddress,
        supply {
            id,
            firstName,
            lastName,
            password,
            dob,
            gender,
            address,
            verified,
            avatar,
            email,
        }
        service {
            id,
            name,
            description,
            basePrice,
        }
        vehicle {
            id,
            name,
            identityNumber,
            color,
            brand,
        }
    }
 }
`;

export const DISAPPROVE_DRIVER = gql`
    mutation disApproveDriver($service_approval_id: ID!) {
        disApproveDriver(service_approval_id: $service_approval_id) {
            id,
            status,
            createdDate, 
            driverLicense,
            personalImg,
            identityImg,
            vehicleImg,
            currentAddress, 
            supply {
                id
                firstName
                lastName
                password
                dob
                gender
                address
                verified
                avatar
                email
            } 
            service {
                id,
                name,
                description,
                basePrice
            }
            vehicle {
                id,
                name,
                identityNumber,
                color,
                brand
            }
        }
  } 
`

export const DELETE_SERVICE_APPROVAL = gql`
    mutation deleteServiceApproval($service_approval_id: ID!) {
        deleteServiceApproval(service_approval_id: $service_approval_id) {
            id,
            status,
            createdDate, 
            driverLicense,
            personalImg,
            identityImg,
            vehicleImg,
            currentAddress, 
            supply {
                id,
                firstName,
                lastName,
                password,
                dob,
                gender,
                address,  
                verified,
                avatar,
                email
            }
            service {
                id,
                name,
                description,
                basePrice
            }
            vehicle {
                id,
                name,
                identityNumber,
                color,
                brand
            }
        }   
    }
`