library("jsonlite")
library(openxlsx)

###################################
#  Creat a Function that take a symbol, a function, sends request to Alpha Vantage API, retrive the response, and returns the close prices.
###################################
Get_price <- function(symbol="MSFT",f="TIME_SERIES_DAILY"){
url <- paste("https://www.alphavantage.co/query?function=",f,"&symbol=",symbol,"&outputsize=full&apikey=apikey",sep = "")# replace 
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
#  reads a list of symbols from an Excel file, calls the function above for each stock symbol to get its stock prices, and saves the data to
#another Excel file in 1 single sheet, of which each column stores prices of 1 symbol.                            #
###########################################
stock_symbol <- read.xlsx("symbols.xlsx",colNames = F)
a <- data.frame()
for (i in 1:5) {
  s <- stock_symbol[i,1]
  p <- Get_price(s)
  a <- rbind(a,p)
}

write.xlsx(a,"output.xlsx")
