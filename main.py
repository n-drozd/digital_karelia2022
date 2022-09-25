import pandas as pd
import requests


df = pd.read_csv("names.csv")
result = []

for row in df.itertuples():
    try:
        name = row.url
        url = "http://" + name
        resp = requests.head(url, timeout=0.5)
        print(resp.status_code)
        if(resp.status_code == 403 or resp.status_code < 300):
            result.append([name])
    except Exception:
        next

df_res = pd.DataFrame(data=result, columns=["url"])
df_res.to_csv("sorted_names.csv", index=False)






