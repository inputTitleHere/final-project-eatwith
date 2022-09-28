
/**
 * number 타입의 "score"를 받음.
 * @param {*} props 
 * @returns 
 */
function Stars(props){
  const avgScore=Math.floor(props.score);
  let sb = '';
  for(let i=0;i<avgScore;i++){
    sb+="\u2605";
  }
  for(let i=0;i<5-avgScore;i++){
    sb+="\u2606";
  }
  return(
    <span className="stars">{sb}</span>
  )

}
export default Stars;