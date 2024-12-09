
# deploy the survey
rsconnect::deployApp(
  appFiles = c('survey.qmd',
               'app.R'),
  appName = 'DummySurvey',
  appTitle = 'Dummy Survey',
  forceUpdate = TRUE
)
