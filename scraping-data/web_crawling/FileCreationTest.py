from pathlib import Path
import pandas as pd

start=1;
end=100;

data = pd.DataFrame([[1,2],[3,4]],columns=list('AB'));

filePath=Path(f'./resultFolder/Scrape_Out_{start}~{end}.csv');
filePath.parent.mkdir(parents=True, exist_ok=True);

data.to_csv(filePath);