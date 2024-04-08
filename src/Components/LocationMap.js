import Card from "../UI/Card";

const LocationMap = (props) => {
    return <Card>
        <img src={`https://maps.googleapis.com/maps/api/staticmap?center=${props.lat},${props.lon}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${props.lat},${props.lon}&key=${process.env.REACT_APP_GOOGLE_MAPS_API_KEY}`} alt="Location on map" />
    </Card>
};

export default LocationMap;