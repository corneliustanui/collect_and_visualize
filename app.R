# remotes::install_github("surveydown-dev/surveydown", force = TRUE)
library(surveydown)

# Database setup

# surveydown stores data on a database that you define at https://supabase.com/
# To connect to a database, update the sd_database() function with details
# from your supabase database. For this demo, we set ignore = TRUE, which will
# ignore the settings and won't attempt to connect to the database. This is
# helpful for local testing if you don't want to record testing data in the
# database table. See the documentation for details:
# https://surveydown.org/store-data

db <- sd_database(
  host   = "",
  dbname = "",
  port   = "",
  user   = "",
  table  = "",
  ignore = TRUE
)


# Server setup
server <- function(input, output, session) {

  # Define any conditional skip logic here (skip to page if a condition is true)
  sd_skip_if()

  # Define any conditional display logic here (show a question if a condition is true)
  sd_show_if(
    input$resp_sex == 3 ~ "resp_sex_other",
    input$resp_educ == 7 ~ "resp_educ_other",
    input$access_elect == 1 ~ "cost_elect"
  )

  # Database designation and other options
  sd_server(

    # connect to database
    db = db,

    # make certain questions compulsory
    required_questions = c("resp_name", "resp_age", "resp_educ"),

    # to make all questions required
    all_questions_required = FALSE,

    # declare start-up page (optional)
    start_page = "page1",

    # admin page
    admin_page = FALSE,

    # allow autocross depending on user progress (optional)
    auto_scroll = TRUE,

    # ask the user to rate the survey experience before they go! (optional)
    rate_survey = TRUE,

    # display UI elements in a certain language (default is 'en')
    language = "en"
  )
}

# shinyApp() initiates your app - don't change it
shiny::shinyApp(ui = sd_ui(), server = server)
