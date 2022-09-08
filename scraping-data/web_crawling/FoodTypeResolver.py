from base64 import encode
import encodings
from heapq import merge
from math import fabs
from msilib.schema import Directory
from operator import truediv
from pickle import FALSE
import pandas as pd
import numpy as np
import pathlib
import os
from functools import reduce
##################################
# Food type resolver Version 0.1 #
##################################
'''
Categorize various food types into selected entries of 10
'''
rootPath = pathlib.Path(__file__).parent.parent
resultFolderPath = rootPath / "resultFolder"

# 음식타입 10종
foodTypeMap = {}
foodCategory = pd.read_excel(rootPath / "음식분류개정.xlsx", index_col=False )
for column in foodCategory:
  series = pd.Series(foodCategory[column])
  series = series.dropna();
  for index, value in series.iteritems():
    # print(f"index : {index} || value : {value}")
    foodTypeMap[value]=column;

# print(foodTypeMap)
#!=====================================================
#* 파일명 회수 및 데이터 번호 추출
resultFileNames=[]
dataStart=[]
dataEnd=[]
for file in os.listdir(resultFolderPath):
  if file.startswith('scr') and file.endswith('.csv'):
    resultFileNames.append(file)
    dataStart.append(int(file[file.rfind('_')+1:file.find("~")]))
    dataEnd.append(int(file[file.find('~')+1:file.find("(")]))

#* 시작 및 끝 데이터 번호 추출
start = min(dataStart)
end = max(dataEnd)
print(f"start = {start} || end = {end}")
# print(resultFileNames)

#* 파일 읽어서 합치기
mergedDf = pd.DataFrame()
for fileName in resultFileNames:
  filepath = resultFolderPath / fileName;
  resultDf = pd.read_csv(filepath, encoding='utf-8', index_col=False,dtype=str)
  resultDf['자치단체코드'] = resultDf['자치단체코드'].apply(lambda x : x[:7])
  mergedDf = mergedDf.append(resultDf,ignore_index=True)
mergedDf = mergedDf.astype("string")

print(mergedDf.dtypes)
print(mergedDf['자치단체코드'])
#* 음식대분류 구분하기
categorize = []

for foodType in mergedDf["음식타입"]:
  if foodType in foodTypeMap:
    categorize.append(foodTypeMap[foodType])
  else:
    categorize.append(np.nan)
# print(categorize)
mergedDf['음식대분류'] = categorize

# 결측데이터 삭제 및 DB 저장용 컬럼명 변경
mergedDf = mergedDf.dropna()
mergedDf = mergedDf[['관리번호','자치단체코드','음식대분류','사업장명','동주소','도로명주소','영업시간','메뉴','업체전화번호','음식타입']]
mergedDf.columns=['no','district_code','food_code','name','dong','address','work_hours','menu','phone','naver_food_type'];
print(mergedDf)

saveDir = rootPath/"mergeResult"
if not os.path.exists(saveDir):
  os.makedirs(saveDir)

mergedDf.to_csv(saveDir/f"result_{start}~{end}-categorized(utf-8).csv",index=False, mode='w',encoding='utf-8')
mergedDf.to_excel(saveDir/f"result_{start}~{end}-categorized.xlsx",f"{start}~{end}",index=False)



