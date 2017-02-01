##ET1541 Assignment submission
##Finalized R Script for E2E IoT Assignment
install.packages("lubridate")

##Calling out all required library packages:
library(ggplot2)
library(plotly)
library(lubridate)


##Step 1: Importing/Retrieving Sensor's date stored in AWS S3 Bucket:
trolleyraw_1 <- read.csv("https://s3-ap-southeast-1.amazonaws.com/trolleyproject/trolleyrawfeeds_2.csv",header=TRUE,sep=",")
  ##Validating
    View(trolleyraw_1)
    str(trolleyraw_1$Time)
    

##Step 2: Using Subset function, filter out all the sensors that reports trolley @ outlet, Msg = "H":
trolley_outlet_sub_1 <- subset(trolleyraw_1, trolleyraw_1$Msg == "H", select = c("Time","Msg"))
  ##Validating    
    View(trolley_outlet_sub_1)  
    


    
##Step 3: Using Aggregate function with "Group By" methodology to count the number of Msg = "H" received per Hour:
aggregate(trolley_outlet_sub_1, list(Period=trolley_outlet_sub_1$Time), length)
  
##Step 4: Create data frame to stored the "aggregated" data in Step 3:
mydata.sub2 <- aggregate(trolley_outlet_sub_1, list(Period=trolley_outlet_sub_1$Time), length)


mydata.sub2$Period <- as.vector(mydata.sub2$Period)
mydata.sub2$Period <- strptime(mydata.sub2$Period, format = "%d/%m/%Y %H:%M")
mydata.sub2 <- mydata.sub2[order(mydata.sub2$Period),]
View(mydata.sub2)

##Validating


##Step 5: Creation of Hour Column
a_1 <- c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
a_2 <- "Hour"
Hour <- data.frame(a_1)


##Step 6: Insert "Hour" Column into data-frame for plotting
mydata.sub2 <- data.frame(mydata.sub2$Period,Hour,mydata.sub2$Msg)
  ##Validating
    View(mydata.sub2)

##Step 7: Change column names
c_1 <- c("Period","Hour","No. of Trolleys in Oulet")
colnames(mydata.sub2) <- c_1
  ##Validating
    View(mydata.sub2)

##Step 8: Using ggplot2() & Plotly, Create finalized Graph w/ interactive Tooltip, Corrected X & Y-Axis, X & Y-Axis Values 
## & Main Chart Title for conclusion:

    ##using ggplot

    q0 <- ggplot(mydata.sub2,aes(x=mydata.sub2$Hour,y=mydata.sub2$`No. of Trolleys in Oulet`))
      q1 <- q0+geom_line()+ggtitle("No. of Trolleys In Outlet vs Hour")+scale_x_continuous(breaks = 0:23)+scale_y_continuous(breaks = 0:12)
        q2 <- q1+geom_point()+labs(x="Hour",y="No. of Trolleys in Outlet")
          ##using ggplotly for 'interactive tooltips'
            ggplotly(q2)

            
    ##End of R Script for functionality
            
##Posting to plotly
Sys.setenv("plotly_username"="sorcerer84")
Sys.setenv("plotly_api_key"="Rdg7WfTJsHmLZQUnWHyZ")
plotly_POST(q2, filename="trolley", sharing="public")
##URL: https://plot.ly/~sorcerer84/2
            
            
            
            
    