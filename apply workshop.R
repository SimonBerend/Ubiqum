
# -------------------------------------------------------------------------
# DESCRIPTION: apply package workshop 
# DEVELOPER: BEREND
# Thu Jan 02 15:13:55 2020 ------------------------------
# -------------------------------------------------------------------------

# Pacman ----------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load("lubridate", "dplyr")

# aplly workshop ----------------------------------------------------------

##############
### Part 1 ###
##############

# In this workshop we will be working with the "apply" functions. They help us avoid loops, 
# which are more computationally intensive and sintactically complex. 

# The "apply family" is made up of these 7 functions: 
# apply()
# lapply()
# sapply()
# vapply()
# mapply() 
# rapply()
# tapply()

# You'll chose the right function depending on the structure of your data and your desired output.

# We will use some dplyr functions in combination with the apply ones

#### apply() ####
# To apply a function to an array (matrix, data frame, data table...)
# The function has 3 arguments:
# X --> the object we want to apply the function to (has to be a matrix, df...)
# Margin --> 1 to apply the function to rows, 2 for columns, or c(1, 2) for both
# FUN --> the function we want to pass to the object

# Construct a 5x6 df
X <- matrix(rnorm(30), nrow=5, ncol=6)
X <- as.data.frame(X)

# Sum the values of each column with `apply()`
colsum <- apply(X, 2, sum)
colsum
class(colsum)

# What would be the equivalent of this with a for loop?

for (i in colnames(X)) {
loopy <- cbind(sum(X[,i]))  
  
}

# Sum the values of each row with `apply()`
rowsum <- apply(X, 1, sum)
rowsum

# Again: what would be the equivalent of this with a for loop?
for (variable in vector) {
  
}

#### lapply() ####
# Same as apply, but it accepts many different objects as inputs and it outputs a list. 
# Arguments:
# X --> the object you want to apply the function to (has to be a list)
# FUN --> the function we want to pass to the object

# Define 3 dataframes and list them:
A <- data.frame(v1 = c(1,2,3), v2 = c(4,5,6), v3 = c(7,8,9))
B <- data.frame(v1 = c(4,5,6,7), v2 = c(8,9,10,11), v3 = c(12,13,14,15))
C <- data.frame(v1 = c(8,9,10), v2 = c(8,9,10))
myList <- list(A, B, C)

#Extract the 2nd column from myList, using lapply and the dplyr function "select"
lapply(myList, "[", , 2)

#Extract the 1st row from myList, using lapply and the dplyr function "slice"
lapply(myList, "[", 1, )

#Extract one single element from every dataframe in the list. You can use "[" as a function
lapply(myList, "[", 2, 2)

#### sapply() ####
#Same as lapply, but returns the simplest output possible (vector instead of list...)
#If we set the argument simplify to FALSE, the output is exactly the same as with lapply!
sapply(myList, "[", 2, 2)
sapply(myList, "[", 2, 2, simplify = F) #same output as lapply!

#### using rep() ####
# rep() is a function from base R that takes an input "x" and replicates it n times.

# Initialize `Z`
Z <- sapply(myList,"[", 1,1 )
Z

# Replicate the values of `Z` 3 times, 1 time and 2 times
rep(Z, times = c(3, 1, 2))

#### mapply() ####
# Multivariate apply: it vectorizes arguments to functions that not usually accept vectors as arguments

# Create a 4x4 matrix called Q1 using the functions matrix() and rep() that looks like this:

# 1 2 3 4
# 1 2 3 4
# 1 2 3 4
# 1 2 3 4


Q1 <- matrix(data = rep(c(1 : 4)), nrow= 4, ncol = 4, byrow = TRUE)
print(Q1)

# Now create the same matrix using `mapply()`
Q2 <- mapply(FUN = rep, x = c(1 : 4), times = 4)
print(Q2)

# The results are the same, we have vectorized the action of the function rep()
# 

##############
### Part 2 ###
##############


df<-read.csv("C:/Users/Gebruiker/Downloads/players.csv")
df

df[,2]<-as.character(df[,2])
df[,3]<-as.character(df[,3])
df[,4]<-as.character(df[,4])
df[,7]<-as.character(df[,7])

# show class of data using a for loop
for (i in colnames(df)) {
  print(class(df[, i]))
} 

# Now try to do the same but with apply(). 
# Notice the limitation of apply function - all classes will be shown as character
apply(df, 2, class)

# Mean of numeric columns with apply()
apply(df[, c(1, 5, 6)], 2 , mean)

# Introduce some NAs
df[1:10, 5] <- NA

#  Mean of numeric columns with apply(): how do we deal with NA's?
apply(df[, c(1, 5, 6)], 2 , mean, na.rm = T)


franchiseList <- unique(df$Franchise)

# In combination with the apply functions, it's very useful to be able to create your own functions
# How would you segregate the dataframe based on one column -- for example, Franchise?
#Keep just the rows for the Bangalore Franchise using base R:
df[df$Franchise=="Bangalore",]

#Now we can generalize this with a function: keep the rows for the Franchise "x"

#Define the function:
segregate_Franchise <- function(x) {
  df[df$Franchise == x, ]
}

#Test your function:
segregate_Franchise("Delhi")

## Now let's make a loop using lapply and the function that we just defined 
# (we can define it again inside the lapply):
OutputList <- lapply(franchiseList, segregate_Franchise)
  
OutputList[1]
OutputList

# We can use the function split() function do a similar task
OutputSplit <- split(df, df$Franchise)
OutputSplit$Delhi



# See also ----------------------------------------------------------------
#
# https://nicercode.github.io/guides/repeating-things/
#
# first.step <- lapply(X, first.function)
# second.step <- lapply(first.step, next.function)
#
# 
#
# elements <- lapply(2:10, function(x){paste0("This is element #", x, "!")})
# elements
# result <- lapply(elements, FUN, additional stuff)


#### ADVANCED SHIT ####

# Using the INDEX argument of T apply, we can create a new array where the dimensions are 
# two columns that we specify.
# This is our goal (Franchise in the rows and Speciality in the columns):
tapply(df, INDEX = c(df$Franchise, df$Specialty))

#              AllRounder Batsman  Bowler WK/Batsman
#Bangalore         NA      NA      NA         NA
#Chennai           NA      NA 2375000    1825000
#Delhi         225000 2450000 1625000     525000
#Hyderabad     850000 3150000 1185000     700000
#Jaipur        475000 1350000  725000     150000
#Kolkata           NA 1825000 2300000     825000
#Mohali            NA  900000 3020000     700000
#Mumbai       1525000  950000 1350000         NA

