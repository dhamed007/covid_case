# Install and load required packages
install.packages(c("tidyverse", "targets", "shiny","futile.logger"))


library(shiny)
library(tidyverse)
library(targets)
library(futile.logger)
library(conflicted)
conflict_prefer("filter", "dplyr")
conflict_prefer("filter", "lag")



# Define the data preprocessing plan using targets
tar_plan <- tar_script({
  # Load the dataset
  obesity_data <- read.csv("obesity_data.csv")
  flog.info("Data loaded")

  # Perform data preprocessing steps if needed
  # For example, handle missing values, transform variables, etc.
  
  # Save the preprocessed data
  tar_target(preprocessed_data, {
    # Return the preprocessed data 
    flog.info("Preprocessing data")
    return(obesity_data)

  })
})

# Define the model training plan using targets
tar_train_model <- tar_script({
  # Load preprocessed data
  preprocessed_data <- tar_read(preprocessed_data)
  flog.info("Preprocessing data loaded")

  # Define and train a simple linear regression model
  model <- lm(Mortality ~ Age + EthnicityRace + Geolocation + Income, data = preprocessed_data)
  flog.info("Model trained")

  # Save the trained model
  tar_target(trained_model, {
    # Return the trained model
    flog.info("Save the trained model")
    return(model)
  })
})

# Define the Shiny app
ui <- fluidPage(
  titlePanel("Mortality Prediction"),
  sidebarLayout(
    sidebarPanel(
      # Add input controls for age, ethnicity/race, geolocation, and income if needed

    ),
    mainPanel(
      plotOutput("prediction_plot")

    )
  )
)

server <- function(input, output) {
  # Load the trained model
  trained_model <- tar_read(trained_model)
  flog.info("Trained model loaded")

  # Define a reactive function for predictions
  predictions <- reactive({
    # Use input values and the trained model for predictions
    # For example: predict(trained_model, newdata = data.frame(Age = input$age, EthnicityRace = input$ethnicity, ...))
    browser()  # Start interactive debugging here
  })

  # Update the plot based on predictions
  output$prediction_plot <- renderPlot({
    # Plot the predictions or any relevant visualization
   
  })

}

# Run the Shiny app
shinyApp(ui, server)
print("This is a log message11")