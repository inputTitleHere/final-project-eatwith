function DongFormatter(dong){
  let dongMod = dong.trim();
  // console.log(dongMod);
  // 가끔 동정보에 이상한 추가데이터가 포함되기도 함. 그것을 잘라냅시다.
  if (dongMod.includes(" ")) {
    dongMod = dongMod.substring(0, dongMod.indexOf(" "));
  }
  return dongMod;
}
export default DongFormatter;