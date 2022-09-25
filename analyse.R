setwd("D:/PT/hax/digital_karelia2022")

df <- read.csv("dataset_to_train.csv", encoding = "UTF-8")
train <- read.csv("train_dataset_train.csv")
c_type <- read.csv("type_contract.csv")
c_type <- c_type[!duplicated(c_type$contract_id),]

df <- merge(df, c_type, by="contract_id")

an <- prcomp(df[,2:length(df)])

n_pc <- 10
l_pc <- 3 - 1 + n_pc
result <- an$x[,1:n_pc]

train <- cbind(train, result)

for(col in 3:length(train)){
  train[,col] <- (train[,col] - min(train[,col]))/(max(train[,col]) - min(train[,col]))
}

#t1 <- train[train$blocked == 1,]
#t2 <- train[train$blocked == 0,]

#train <- rbind(t1[1:400,], t2[1:400,])

l_pc <- 3 - 1 + 15

vect <- train[1,3:l_pc]

for(ex in 7:14){
  alpha <- 10^(-ex)
  print(ex)
  for(i in 1:10){
    for(row in 1:length(train[,1])){
      if(sum(abs(train[row, 3:l_pc])) > 150){
        next
      }
      f <- sum(vect * train[row, 3:l_pc])
      val <- train[row, "blocked"]
      
      if (val == 0 & f > 0){
        next
      }
      if (val == 0 & f < 0) {
        vect = vect + alpha * train[row, 3:l_pc]
      }
      if (val == 1 & f < 0) {
        next
      }
      if (val == 1 & f > 0) {
        vect = vect - alpha * train[row, 3:l_pc]
      }
    }  
  }
}


tp = 0
fp = 0
for(row in 1:length(train[,1])){
  f <- sum(vect * train[row, 3:l_pc])
  val <- train[row, "blocked"]
  
  print(f)
  if (val == 1 & f < 0){
    tp = tp + 1
  }
  
  if(val == 0 & f < 0){
    fp = fp + 1
  }
}


