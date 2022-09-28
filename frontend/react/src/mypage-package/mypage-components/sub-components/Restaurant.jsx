import { useParams } from "react-router-dom";


function Restaurant(props){
  const params = useParams();
  console.log(params);
  const restaurantNo = params.restaurant_no;
  return(
    <div className="restaurant-wrapper">
      {restaurantNo}
    </div>
  )
}

export default Restaurant;