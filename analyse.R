setwd("D:/PT/hax/digital_karelia2022")

contracts <- read.csv("type_contract.csv")
left <- read.csv("train_dataset_train.csv")
log <- read.csv("log.csv", encoding = "UTF-8")

tab <- matrix(ncol = length(unique(log$event_type)) + 1, nrow = length(unique(log$contract_id)))
colnames(tab) <- c("contract_id" ,unique(log$event_type))

df <- as.data.frame(tab)
df$contract_id <- unique(log$contract_id)

for(row in 1:nrow(df)){
  c_id <- df[row, ]$contract_id
  
  for(col in 2:ncol(df)){
    colname <- colnames(df)[col]
    count <- length(log[log$contract_id == c_id & log$event_type == colname, ]$contract_id)
    print(count)
    df[row, colname] <- count
  }
}

write.csv(df,"df.csv", row.names = FALSE, fileEncoding = "UTF-8")

total <- merge(contracts, left, "contract_id")

