import BestReviews from "./index-items/BestReviews.jsx";
import NewestReviews from "./index-items/NewestReviews.jsx";
import NewestGatherings from "./index-items/NewestGatherings.jsx";
import NearClosureGatherings from "./index-items/NearClosureGatherings.jsx";
import "./css/index.scss";
import "./css/root.css";
// import NearRestaurants from "./NearRestaurants";

function Index(props) {
  return (
    <div className="content-root">
      <div className="content-wrapper">
        <BestReviews />
      </div>
      <div className="content-wrapper">
        <NearClosureGatherings/>
      </div>
      <NewestReviews/>
      <div className="content-wrapper" id="newest-gather-wrapper">
        <NewestGatherings/>
      </div>
    </div>
  );
}
export default Index;
