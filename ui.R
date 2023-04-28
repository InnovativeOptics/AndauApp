#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)
library(bslib)

# Load Andau loupe data
andau_data <- readxl::read_excel("andau_loupe_data.xlsx")

# Load dental data

dental_data <- readxl::read_excel("Dental_data.xlsx")%>%
  filter(`Laser Mfg` != "") %>%
  mutate(VLT = scales::percent(as.numeric(VLT)))
  

# theming options
andau_theme <- bs_theme(version = 5,
                        base_font  = font_google("Karla"),
                        bg = "white",
                        fg = "#1f0900",
                        primary = "#ff4d00")
# Define application UI
shinyUI(page_fluid(theme = andau_theme,
                   card(card_header(inverse = T,fluidRow(
                     column(6,
                            align = 'left',
                            div(strong("Andau Medical")),
                                div(a("www.andaumedical.com", href = "https://www.andaumedical.com"))),
                     column(6, align= 'right',
                            div("customerservice@andaumedical.com"),
                            div("1-844-263-2888"))))
                   ,fluidRow(column(12,align='center',
                                    h3("Search eye protection by selecting a loupe style, and a laser device")))
                   ),
                   card_body(fluidRow(
                         column(
                           2,
                           selectInput(
                             inputId = "loupestyle",
                             label = "Loupe Style",
                             choices = sort(andau_data$`Andau Frame`),
                             selected = NULL
                           )
                         ),
                         column(
                           4,
                           selectInput(
                             inputId = "mfg",
                             label = "Laser Manufacturer",
                             choices = sort(dental_data$`Laser Mfg`),
                             selected = NULL
                           )
                         ),
                         column(
                           4,
                           selectInput(
                             inputId = "mod",
                             label = "Model",
                             choices = dental_data$`Laser Model`,
                             selected = NULL
                           )
                         ),
                         column(
                           2,
                           align = "center",
                           br(),
                           actionButton("run",
                                        "Search",
                                        class = "btn-primary")
                         )
                       )),
                       conditionalPanel(
                         condition = "input.run",
                         card_body(fluidRow(column(12, align = "center",
                                         em("Device Information"),
                                         tableOutput("userInfo"))),
                         fluidRow(column(12,
                                         align = "center", 
                                         em("Compatible Innovative Optics Product"),
                                         tableOutput("tableInfo"))),
                         fluidRow(column(12, align = 'center',
                                         imageOutput("productImage")))),
                         card_body(fluidRow(column(12,
                                  align = 'left',
                                  strong("Frequently Purchased Together"))),
                         fluidRow(
                           column(4, align = 'center',
                             imageOutput("rec1"),
                           tableOutput("tableRec1")),
                           column(4, align = 'center',
                                  imageOutput("rec2"),
                                  tableOutput("tableRec2")),
                           column(4, align = 'center',
                                  imageOutput("rec3"),
                                  tableOutput("tableRec3")))
                         )),
                       card(card_footer("Powered by Innovative Optics"))
                   ))


  # sidebarLayout(
  # sidebarPanel(
  #   width = 4,
  #   selectInput(
  #     inputId = "loupestyle",
  #     label = "First, select your style of Andau loupes!",
  #     choices = andau_data$`Andau Frame`,
  #     selected = NULL
  #   ),
  #   selectInput(
  #     inputId = "mfg",
  #     label = "Next, select your laser's manufacturer!",
  #     choices = dental_data$`Laser Mfg`,
  #     selected = NULL
  #   ),
  #   selectInput(
  #     inputId = "mod",
  #     label = "Finally, select your laser model!",
  #     choices = dental_data$`Laser Model`,
  #     selected = NULL
  #   )
  # ),
  # mainPanel(width = 8,
  #           tableOutput("tableInfo"))





# Define UI for application that suggest eyewear based on loupe type and laser type
# shinyUI(fluidPage(
#     # Application title
#     h3("Welcome to the interactive dashboard"),
#     h4("Where you can easily find which inserts fit your loupes and which lens protects against your laser!"),
#     hr(),
#     sidebarLayout(sidebarPanel(
#     selectInput("frame",
#                        "First, select the style of loupes!",
#                        choices = andau_data$`Andau Frame`,
#                        selected = NULL),
#     h5("Next, select if you want to search by laser Category /n or by using our Dental or Medical laser lists!"),
#     tabsetPanel(
#       id = "profession",
#       type = "pills",
#       tabPanel("Category",
#         h5("Finally, select your laser category!"),       
#         selectInput("category",
#                     "Laser Category",
#                     choices = category_list,
#                     selected = NULL)),
#       tabPanel("Dental", 
#                h5("Finally, select your laser manufacturer and model!"),
#                selectInput("dentman",
#                            "Dental laser manufacturer",
#                            choices = dental_data$`Laser Mfg`,
#                            selected = NULL),
#                selectInput("dentmod",
#                            "Dental laser model",
#                            choices = dental_data$`Laser Model`,
#                            selected = NULL)),
#       tabPanel("Medical", 
#                h5("Finally, select your laser manufacturer and model!"),
#                                selectInput("medman",
#                                            "Medical laser manufacturer",
#                                            choices = medical_data$`Laser Mfg`,
#                                            selected = NULL),
#                                selectInput("medmod",
#                                            "Medical laser model",
#                                            choices = medical_data$`Laser Model`,
#                                            selected = NULL))
#                         )
#     ),
#     mainPanel(tableOutput("suglensCategory"),
#               tableOutput("sugdent"),
#               tableOutput("sugmed"),
#               imageOutput("Loupe"))
#     )
#   )
#)

