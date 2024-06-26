import axios from 'axios';
import queryString from 'query-string';

const axiosClient = axios.create({
  baseURL: process.env.REACT_APP_BACKEND_HOST ?? 'http://localhost:5003',
  headers: {
    'content-type': 'application/json',
    // Authorization: Bearer ${accessToken},
  },
  paramsSerializer: (params) => queryString.stringify(params),
});

// export const setAccessToken = (token: string) => {
//   axiosClient.defaults.headers.common['Authorization'] = `Bearer ${token}`;
// };

axiosClient.interceptors.request.use(async (config) => config);

axiosClient.interceptors.response.use((response) => {
  if (response && response.data) {
    return response.data;
  }
  return response;
}, (error) => {
  // Handle errors
  throw error;
});

export default axiosClient;