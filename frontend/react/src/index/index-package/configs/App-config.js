const hostName = window && window.location && window.location.hostname;
let backendHost;
if(hostName ==='localhost'){
	backendHost = "http://localhost:9090/eatwith";
}
export const API_BASE_URL=`${backendHost}`;