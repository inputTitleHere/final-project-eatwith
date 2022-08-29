from pickle import FALSE
import pandas as pd;
from os import listdir

# result_folder 속의 결과 csv 파일들의 이름을 추출
# vscode상 열린 폴더구조의 루트폴더
relativeFilePath = "./resultFolder/"
resultFiles = [files for files in listdir(relativeFilePath) if files.endswith(".csv") and files.startswith('scr')]

mergedDataframe = pd.DataFrame();

for fileName in resultFiles:
  fp = relativeFilePath + fileName
  resultDf = pd.read_csv(fp, encoding='utf-8',index_col=False)
  mergedDataframe = mergedDataframe.append(resultDf, ignore_index=True)

# print(mergedDataframe)
# print(mergedDataframe['음식타입'].unique())
# print(len(mergedDataframe['음식타입'].unique()))

foodTypes = pd.DataFrame(mergedDataframe['음식타입'].unique(),columns=["Unique 음식타입"])
foodTypes.to_csv(relativeFilePath+"유니크 음식타입_utf-8.csv",mode='w', index=False,encoding='utf-8')

print("\n끝났습니다.\n")