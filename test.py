import pandas as pd
import numpy as np

sorted = pd.read_csv("sorted_names.csv")
named = pd.read_csv("named.csv")
named = named[named["url"].isin(sorted["url"])]
contract_ids = pd.read_csv("train_dataset_train.csv")

result = pd.DataFrame(columns=sorted["url"])
result["contract_id"] = contract_ids.head(1)["contract_id"]
result = result.fillna(0)

url_n = 0
for row in range(0, len(result["contract_id"])):
    c_id = contract_ids["contract_id"][row]
    valid_urls = sorted["url"]

    for url in valid_urls:
        count = len(named[(named.url == url) & (named.contract_id == c_id)])
        print(f'{c_id} {count} {url}')
        result.at[row, "url"] = count
        print(result.at[row, "url"])

print(result)
