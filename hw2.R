setwd("C:/Users/Arche/graduate/R working directory/math5670/hw2")
library("jsonlite")
library(openxlsx)

###################################
# Question1: Creat a Function    ##
###################################
Get_price <- function(symbol="MSFT",f="TIME_SERIES_DAILY"){
url <- paste("https://www.alphavantage.co/query?function=",f,"&symbol=",symbol,"&outputsize=full&apikey=QMX2818MD2YFERQG",sep = "")
data <- fromJSON(url)
day <- names(data$`Time Series (Daily)`)
close_price <- array()
for (i in 1:length(day)) {
  d <- day[i]
    close_price[i] <- data$'Time Series (Daily)'[[d]]$'4. close'
  }
    mydata <- data.frame(symbol,day,close_price)
    return(mydata)
}

############################################
#  Question 2                             #
###########################################
stock_symbol <- read.xlsx("symbols.xlsx",colNames = F)
a <- data.frame()
for (i in 1:5) {
  s <- stock_symbol[i,1]
  p <- Get_price(s)
  a <- rbind(a,p)
}

write.xlsx(a,"output.xlsx")
