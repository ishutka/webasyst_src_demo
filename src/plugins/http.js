import axios from 'axios';
import qs from 'qs';

const baseURL = '/';

const csrf = document.querySelector('input[name="_csrf"]').value;
const HTTP = axios.create({
  baseURL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
    'x-requested-with': 'XMLHttpRequest',
    'Cache-Control': 'no-cache',
    Pragma: 'no-cache',
  },
});
HTTP.interceptors.request.use(request => {
  if (
    request.data &&
    request.headers['Content-Type'] === 'application/x-www-form-urlencoded'
  ) {
    request.data._csrf = csrf;
    request.data = qs.stringify(request.data);
  }
  return request;
});
export default HTTP;
