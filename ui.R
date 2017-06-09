#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Demo Of The Next Word Prediction App"),
  p("Enter your words then this app will predict the next word based on your last 1-3 words."),
  
  sidebarLayout(
    sidebarPanel(
        textAreaInput("your_words", "Please Enter Your Words (English Only)", "how are you"),
        radioButtons("select_word","Belows are Your Top Predicted Next Words (based on your last 1-3 words)",c(""),selected = character(0)),
        radioButtons("top", "Select Number Of Top Predicted Next Words",
                     c("1" = 1,
                       "3" = 3,
                       "5" = 5),
                     selected = 3),
        actionButton("clear", "Clear Text"),        
        width = 6
    ),
    
    
    mainPanel(
        h3("For more detail, please see the presentation"),
        a(
                href = "http://rpubs.com/suteak/283308"
                ,
                "http://rpubs.com/suteak/283308",
                target = "_blank"
        )
    )
  )
))
