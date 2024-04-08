import { useEffect, useState } from "react";
import classes from './IpAddress.module.css';
import LocationMap from "./LocationMap";

const IpAddress = () => {
    const [ip, setIp] = useState({});
    const [httpError, setHttpError] = useState(null);
    useEffect(() => {
        // fetch('https://api.ipify.org?format=json')
        fetch('http://ip-api.com/json')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch IP address.');
                } else {
                    setHttpError(null);
                    return response.json();
                }
            })
            .then(data => {
                    console.log(data);
                    setIp(data);
                })
            .catch(error => setHttpError("Failed to retrieve IP address, please try again later. "));
    }, []);

  return (
    <div>
        { !httpError && (
            <>
                <div className={classes.info}>
                    <p>
                        <span className={classes.bold}>Public IPv4 Address: </span> 
                        {ip.query}
                    </p>
                    <p>
                        <span className={classes.bold}>Internet Service Provider: </span> 
                        {ip.isp}
                    </p>
                    <p>
                        <span className={classes.bold}>Location: </span> 
                        {ip.city}, {ip.regionName}, {ip.country}
                    </p>
                </div>
                <LocationMap lat={ip.lat} lon={ip.lon} />
            </>
        )}
        {/* <h1>{ip.query}</h1> */}
        {httpError && <p>{httpError}</p>}
    </div>
  );
}   

export default IpAddress;