import type { paths } from './fdai';
import createClient from 'openapi-fetch';

let bearerToken = "demo"
export let { GET, POST, PATCH, PUT, DELETE, HEAD, TRACE } = createClient<paths>(
  {
    baseUrl: 'https://safe.fdai.earth/api/v3',
    headers: { authorization: `Bearer ${bearerToken}` } //Add your auth here, not needed for public APIs like petstore in this example
  },
);
