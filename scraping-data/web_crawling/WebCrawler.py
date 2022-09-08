
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
import pandas as pd
import time
import hanja
import pathlib

'''
# Version 1.6 #
# Changed File path system to work regardless of folder or workspace directory using filepath of this python file.

# Version 1.5 #
# Naver changed it's Naver maps layout causing previous code to be ineffective.
# Compensated neccesary changes to keep the logic working

# Version 1.4.2 #
# Added checked wait 
# element = WebDriverWait(driver,3).until(EC.presence_of_element_located((By.XPATH,'//*[@id="_title"]/span[2]')))
# before Data retreival section

# Version 1.4.1 #
# Minor additions in print debug #

# Version 1.4 #
# now if multiple search results are found, it attempts to find a matching name. e.g case of '자이식당 잠원로 24' the first search result is actually a starbucks coffee shop where the second entry is the actual restaurant with name '자이식당'. 
# this usually is a rare case and if no matching names are found, then just use the first selection.


# Version 1.3 #
# Now Capable for handling multi-result queries by selecting the first one
'''

#&========================================================
start=14000
end=15000
currIndex = start
#&========================================================




#! 메소드 영역
def addressBuilder(address):
  # ~로 이면 숫자까지 추출, ~길이면 길까지만 추출.
  if('구로구' in address):
    startLoc=address.find('구로구')+4
  else:
    startLoc = address.find('구')+2
  comparatorLoc = address.find(' ', startLoc)-1
  if(address[comparatorLoc] == '길'):
      address = address[startLoc:address.find(' ', startLoc)]
  else:
      address = address[startLoc:address.find(
          ' ', address.find('로', startLoc)+2)]
  return address

def nameBuilder(name):
  if(name.startswith('(주)')):
    name = name[3:]
  
  pos = name.find('(')
  if(pos != -1 and pos != 0):
    name = name[:pos]
  elif(pos == 0):
    name = name[name.find(")")+1:]
  
  pos = name.find('[')
  if(pos!=-1):
    name=name[:pos]
    
  if(name.endswith('점')):
    if(name.rfind(' ')!=-1):
      name = name[:name.rfind(' ')]

  name = hanja.translate(name,'substitution') #혹여 있을 한자 제거.
  return name

def getDong(address):
  startLoc = address.find(" ",8) # 중구가 있기 때문에 +8을 한다.
  address=address[startLoc:address.find(" ",startLoc+1)]
  return address

#! 메소드 끝
#&========================================================
print(
  "# ================================================ #\n"+
  "# Naver Map Restaurant Data Scrapper Version 1.6   #\n"+
  "# Updated at 2022/08/31                            #\n"+
  "# ================================================ #\n"
)
#&========================================================


#! SELENIUM
#^ Selenium이 사용할 웹드라이버 명시. -> 크롬을 사용할 것임
options = webdriver.ChromeOptions()
options.add_experimental_option('excludeSwitches', ['enable-logging'])
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),options=options)
# driver = webdriver.Chrome()
driver.implicitly_wait(1) # 암묵적 로딩 1초 기다려주기

#! PANDAS
#^ 검색할 데이터를 로드한다. CSV형식으로
# https://data.seoul.go.kr/dataList/OA-16094/S/1/datasetView.do
# 위 링크에서 받아서 폐업한 데이터를 삭제하였다. (+ UTF-8으로 저장.)
# 이거 VSCode상 연 루트폴더의 위치에 대해 상대적으로 작동하는 듯 하다. 실행 파이썬 코드가 아니라.
pyFilePath = pathlib.Path(__file__).parent
#c:\Workspaces\spring_workspace\final-project-eatwith-side\scraping-data\web_crawling
folderRoot = pathlib.Path(__file__).parent.parent 
#c:\Workspaces\spring_workspace\final-project-eatwith-side\scraping-data
# print(folderRoot / "blablablabla") # 파이썬은 연산자 오버로딩 지원

data = pd.read_csv(pyFilePath / 'OriginalData' / '서울시 일반음식점 인허가 정보-UTF-8.csv', encoding='utf-8')
data = data[['개방자치단체코드','관리번호', '지번주소','도로명주소', '사업장명']] # 업체구분 제거
#^ 주소 또는 이름이 Nan인 결측치(값없는거) 제거
data=data.dropna(axis='rows')

#^ 결과를 담을 테이블
columns = ['관리번호', '사업장명','동주소','자치단체코드','도로명주소','음식타입','영업시간', '메뉴', '업체전화번호']
saveData = pd.DataFrame(columns=columns)
# print(saveData)

#! 로깅용 파일 선언
logFilePath=folderRoot / "resultFolder"
logFilePath.parent.mkdir(parents=True, exist_ok=True)

logSuccess = open(logFilePath / "logSuccess.log",'a+',buffering=1,encoding='utf-8') # 없으면 생성.
logFail = open(logFilePath / "logFailed.log",'a+',buffering=1,encoding='utf-8')

#! 기본 변수 선언부
urlBase = 'https://map.naver.com/v5/search/'



#! 반복문 시작
try:
  #! 초기 페이지 설정
  driver.get("https://map.naver.com/v5/")
  element=WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.CLASS_NAME,'input_search')))
  
  #TODO : 입력받았을 당시 여러개의 경우가 있는 경우에 선택가능 리스트를 순회하여 이름과 동일한 엔트리를 찾고 그걸 click해보도록.
  
  
  for index, row in data[start:end].iterrows(): 
    print("-----------------------------------------------")
    # 입력창 구하기
    driver.switch_to.default_content()
    searchBox = driver.find_element(By.CLASS_NAME,'input_search')
    searchBox.clear()
    # 로그용 인덱스 번호 포매팅 처리:
    # 예 : 37번 -> 0000037
    currIndexStr = str(currIndex).zfill(7)
    
    address = addressBuilder(row['도로명주소']) # * 쿼리용 주소 추출
    name = nameBuilder(row['사업장명']) # * 쿼리용 이름 추출
    query = name + " " + address #* 완성된 쿼리용 구문
    print(f'# {currIndexStr}번 쿼리 : [{query}] #')
    
    # 실질 페이지 검색
    # driver.get(urlBase+query)
    searchBox.send_keys(query)
    searchBox.send_keys(Keys.RETURN)
    # print(f" 검색어 [{query}] 입력 ")
    
    WebDriverWait(driver,5).until(lambda driver : driver.execute_script('return document.readyState')=='complete')
    time.sleep(1)
    
    try:
      #^ entryIframe으로 전환.
      element=WebDriverWait(driver,5).until(EC.presence_of_element_located((By.ID,"entryIframe"))) # iframe으로 들어가야 한다.
      iframe = driver.find_element(by=By.ID,value="entryIframe")
      driver.switch_to.frame(iframe)
      
      print(f"# {query} entryIframe 전환")
      time.sleep(0.5) 
    # entryIframe 요소를 찾지 못한 경우
    except Exception as exception:
      print(f"@ Error : {query} - entryIframe 로드 실패")
      try: #~ 그냥 업체가 없는 경우는 바로 다음 쿼리로 넘기기
        searchIframe = driver.find_element(By.ID,'searchIframe')
        driver.switch_to.frame(searchIframe)
        print(f"@ {query} - Switching to searchIframe")
        time.sleep(0.5)
        # notExist = driver.find_element(By.CLASS_NAME,'_3wOk5').get_attribute('innerText')
        #~ notExist : innerText으로 '조건에 맞는 업체가 없습니다' 확인.
        notExist = driver.find_element(By.XPATH,'//*[@id="app-root"]/div/div[2]/div/div').get_attribute('innerText');
        
        if "조건에" in notExist:
          print(f"$ NO_RESULTS = {currIndexStr}번 항목 '{query}' -> 조건에 맞는 업체가 없습니다.")
          logFail.writelines(f"NO_RESULTS : {currIndexStr}번 항목 Query = '{query}'\n")
          time.sleep(1)
          currIndex+=1
          continue
        else:
          raise Exception()
      except:
        #~ 가끔씩 하나의 쿼리에 여러개의 결과가 나올 때가 있다. 
        #이 경우 항상 이름값들을 읽어서 우선 매칭되는 이름이 있는지 탐색하겠다.
        try:
          placeNames = driver.find_elements(By.CLASS_NAME,'place_bluelink');
          print(f"!! Found Multiple Entries with Query : {query} !!")
          useFirst=True
          indexPos=1
          for place in placeNames: # 클릭가능한 목록을 훑고
            if name in place.get_attribute('innerText'): # 이름 매칭되는게 있으면(상단순) 바로 클릭
              logSuccess.writelines(f"Selected entry no.{indexPos}")
              print(f"& Selected entry no.{indexPos}")
              useFirst=False #플래그 치우기
              place.click()
              break
            indexPos+=1
          if(useFirst): #만약 100%매칭이 없으면 그냥 첫번째꺼 사용.
            firstLink = driver.find_element(By.CLASS_NAME,'place_bluelink')
            logSuccess.writelines("Selected entry no.1")
            print("& Selected DEFAULT entry no.1")
            firstLink.click()
          time.sleep(0.5)
          # 다시 상단 프레임으로
          driver.switch_to.default_content()
          # 로드까지 대기
          WebDriverWait(driver,5).until(EC.presence_of_element_located((By.ID,"entryIframe")))
          iframe = driver.find_element(by=By.ID,value="entryIframe")
          driver.switch_to.frame(iframe)
          time.sleep(0.5)
        except:
          # 가끔 무한로딩 걸려서 못찾는 경우가 있다. 이 경우 한번만 더 실행시킨다.
          try:
            # driver.get(urlBase+query)
            searchBox.send_keys(query)
            searchBox.send_keys(Keys.RETURN)
            print(f"# {currIndexStr} - {query} [2차 시도] ---- ")
            element=WebDriverWait(driver,10).until(EC.presence_of_element_located((By.ID,"entryIframe"))) 
            iframe = driver.find_element(by=By.ID,value="entryIframe")
            #^ iframe으로 전환.
            driver.switch_to.frame(iframe)
            time.sleep(0.5) 
          except:
            # 2번 못찾으면 그냥 포기
            # print(exception)
            print(f"!! LOADING_FAILED = {currIndexStr}번 항목 '{query}' -> 로딩에 실패했습니다.")
            logFail.writelines(f"LOADING_FAILED : {currIndexStr}번 항목 Query = '{query}'\n")
            time.sleep(1)
            currIndex+=1
            continue
    
    #& 데이터 회수 섹션 : Data retreival section
    #? 음식 타입 =====================================================
    element = WebDriverWait(driver,3).until(EC.presence_of_element_located((By.XPATH,'//*[@id="_title"]/span[2]')))
    foodType_xpath=driver.find_element(By.XPATH,'//*[@id="_title"]/span[2]')
    foodType=foodType_xpath.get_attribute("innerText")
    print(f"|| foodType={foodType}",end=" - ")
    
    #? 영업 시간 =====================================================
    #! xpath하다가 깨져서 안함 ㅋㅋ
    try:
      # 영업시간 a 태그 위치.
      workHours=driver.find_element(By.CLASS_NAME,'vVPEo')
      workHours.click()
      time.sleep(0.5) # 클릭 이후 1초 대기
      # workHours_str = workHours.text
      # 2022 08 27 update
      workDays = driver.find_elements(By.CLASS_NAME,"kGc0c")
      workTime = driver.find_elements(By.CLASS_NAME,'qo7A2')
      workHours_str=""
      
      #가끔 [닭발의화신 곰달래로41] 이런애들이 영업시간이 이상한 경우가 있다.
      #이들은 하나의 span에 내용을 다 퉁쳐서 넣는 듯 하다.
      if len(workDays)==0: # 2022 08 27 update
        workDaysMerged=driver.find_elements(By.CLASS_NAME,"ob_be")
        for item in workDaysMerged:
          workHours_str=workHours_str+item.get_attribute('innerText')+"\n"
      else:
        for i in range(len(workDays)):
          workHours_str= workHours_str+workDays[i].get_attribute('innerText')+"/"+workTime[i].get_attribute('innerText').replace("\n","/") + "\n"
      
      print(f'workHours_str={workHours_str[:8]}...',end=" - ") 
      time.sleep(1) # 텍스트 로드 이후 1초 대기
    except:
      workHours_str = "등록된 영업시간이 없습니다."
      print('등록된 영업시간이 없습니다.',end=" - ")  
    
    
    #? 전화번호 =====================================================
    try:
      phoneNumber = driver.find_element(By.CLASS_NAME,'dry01').get_attribute('innerText')
      
      '''
      #~ 아마 변경사항이 050이면 그냥 번호 안뜨게 바꾼 모양이다. 그래서  클래스이름하고 다 바뀐듯. 아래 코드는 무용.
      if phoneNumber.startswith('050'):
        try:
          driver.find_element(By.CLASS_NAME,'vUqKY').click()
          phoneNumber=driver.find_element(By.CLASS_NAME,'_1Ma5c').get_attribute('innerText')
        except:
          pass
      '''
      time.sleep(0.5)
      print(f"phoneNumber={phoneNumber}",end=" - ")
    except:
      print("등록된 전화번호가 없습니다.",end=" - ")
      phoneNumber="등록된 전화번호가 없습니다."
    #? 메뉴판 =====================================================
    try: #~ 메뉴판은 텍스트 기반의 xpath으로 검색한다.(써먹어보자)
      menuButton = driver.find_element(By.XPATH,"//span[text()='메뉴']")
      menuButton.click() # 여기서 아마 except으로 이동 가능.
      time.sleep(0.5)
      #~ 이거 classname말고 xpath으로 생각을 해봤는데 그냥 확인해서 CLASS_NAME으로 굴리는게 나을지도 모르겠다.
      #! 메뉴 관련 ClassName 20220827 갱신.
      menuNames = driver.find_elements(By.CLASS_NAME,'Sqg65') #! menuName
      menuPrices = driver.find_elements(By.CLASS_NAME,'SSaNE') #! menuPrice
      menuString = ""
      
      if len(menuNames)!=0 : #* 일반 메뉴판 인 경우.
        for i in range(len(menuNames)):
          menuString = menuString + menuNames[i].get_attribute('innerText') + " : " + menuPrices[i].get_attribute('innerText') + "\n"
      else: #* 배달의 민족 메뉴판인 경우.
        menuNames=driver.find_elements(By.CLASS_NAME,'name')
        menuPrices=driver.find_elements(By.CLASS_NAME,'price')
        if len(menuNames)!=0:
          for i in range(len(menuNames)):
            menuString=menuString+menuNames[i].get_attribute('innerText') + " : " + menuPrices[i].get_attribute('innerText') + "\n"
        else: #* N 주문 메뉴판인 경우
          menuNames=driver.find_elements(By.CLASS_NAME,'tit')
          menuPrices=driver.find_elements(By.CLASS_NAME,'price')
          if len(menuNames)!=0:
            for i in range(len(menuNames)):
              menuString=menuString+menuNames[i].get_attribute('innerText') + " : " + menuPrices[i].get_attribute('innerText') + "\n"
          else:
            menuString = "알수 없는 형식의 메뉴판입니다."
      print(f"menu={menuString[:8]}...",end=" || ")
      # print(menuString)
      time.sleep(0.5)
    except: # 메뉴버튼이 없으면 실행되는 코드
      menuString = "등록된 메뉴가 없습니다."
      print("등록된 메뉴가 없습니다.",end=" || ")
    
    
    print()
    #^ 판다스에 저장
    managementNumber = row['관리번호'] #! 관리번호
    #~ 이름은 위에서 선언된거 사용. : name 변수
    dongAddress = getDong(row['지번주소']) #! 동주소
    acCode = row['개방자치단체코드'] #! 개방자치단체코드 - acCode
    fullAddress = row['도로명주소']
    #~ 음식타입은 위에 있음.  : foodType 변수
    #~ 영업시간 위에 있음. : workHours_str
    #~ 메뉴 위에 있음 : menuString
    #~ 전화번호 위에 있음 : phoneNumber
    # 결과를 db에 등재 할 수 있도록 Series에 담는다.
    result = pd.Series({
      '관리번호':managementNumber,
      '사업장명':name,
      '동주소':dongAddress,
      '자치단체코드':acCode,
      '도로명주소':fullAddress,
      '음식타입':foodType,
      '영업시간':workHours_str, 
      '메뉴':menuString, 
      '업체전화번호':phoneNumber
    })
    # print(result)
    # append으로 Series를 기존의 테이블에 행단위로 추가한다.
    saveData=saveData.append(result,ignore_index=True)
    
    logSuccess.writelines(f"{currIndexStr}번 항목 Query = '{query}' : SUCCESS\n")
    currIndex+=1
    time.sleep(1)
  #! for 끝
except Exception as e : # 실행중 중대규모 오류 발생시
  print(e)
  logFail.writelines(f"Log.Error : {currIndex} 실행중 오류(인터넷끊김 등)로 중단하였음. \n")
finally:
  #! for ends here
  #^ close Logging
  logSuccess.writelines(f"====== Logged from {start} to {currIndex} ======\n")
  logFail.writelines(f"====== Logged from {start} to {currIndex} ======\n")
  
  logSuccess.close()
  logFail.close()

  # print(saveData)

  #! 결과를 CSV으로 저장.
  # logFilePath하고 resultpath은 동일
  savePath = logFilePath / f"scraping_Result_{start}~{currIndex}(utf-8).csv"
  saveData.to_csv(savePath,mode='w',encoding='utf-8',index=False)

print(f"\n!!! ROGRAM HAS FINISHED !!! \n# Ran from {start} to {currIndex} #")
print("#============================#")


