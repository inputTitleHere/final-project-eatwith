
const hostName = window && window.location && window.location.hostname;
let backendHost;
if(hostName ==='localhost'){
	backendHost = "http://localhost:9090/eatwith";
}

console.log("app-config은 로드됨");

export const API_BASE_URL=`${backendHost}`;