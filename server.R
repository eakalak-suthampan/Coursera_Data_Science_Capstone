#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# load ngrams data
source("load_ngram.R")

# load my predict nextword function
source("predict_nextword.R")

shinyServer(function(input, output, session) {
        
        # observe text inputs and predict the next words 
        observeEvent(input$your_words,{
                updateRadioButtons(session, "select_word"
                                   ,choices = predict_nextwords(input$your_words,input$top)
                                   ,selected = character(0)
                )
                
        })
        
        # when click on radio button, append the predicted word to user text input
        observeEvent(input$select_word, {
                updateTextInput(session,"your_words"
                                , value = paste(gsub("\\s*$","",input$your_words)
                                ,input$select_word,sep = " "))
        })
        
        # observe when click on the clear text button
        observeEvent(input$clear, {
                updateTextInput(session,"your_words", value = "")
                })
        
        # observe when changing number of top predicted words
        observeEvent(input$top, {
                updateRadioButtons(session, "select_word",
                                   choices = predict_nextwords(input$your_words,input$top),
                                   selected = character(0)
                )
        })
        
        
})
