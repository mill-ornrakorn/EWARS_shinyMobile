##objects

##login items  

login_screen<-fluidPage(tags$h1("EWARS Dashboard"),
                        column(width=8,align="left",offset =0,
box(width =4,
wellPanel(tags$h3("Please login"),
                         textInput("user_name","user name",value="demo"),
                        passwordInput("pwd","Password",value="demo_2019"),
                        actionButton("lg_in","login",
                                     style="color: white; background-color:#3c8dbc;
                                 padding: 10px 15px; width: 150px; cursor: pointer;
                                 font-size: 18px; font-weight: 300;")
          
                        )

)
)
)

output_graphs<-
  f7Tabs(style = "strong",
         animated = TRUE,
         swipeable = FALSE,

         
  
  #--------output_graphs--------
  f7Tab(title ="Runnin",
                    open = TRUE,
          tabName ="Runnin",
             
               
                      verbatimTextOutput("messageCheckData_1"),
                      div(
                        id = "your_graph_id",
                        # style="max-height:500px; overflow-y: scroll; position: relative",
                        style=" overflow-y: scroll; position: relative",
                          # addSpinner(plotlyOutput("plot1",height ="80vw"), 
                          #            spin = "bounce", color = "#007aff"
                          #              )
                        addSpinner(plotlyOutput("plot1",height ="100vw"),
                                   spin = "bounce", color = "#007aff"
                                     )
                        # plotlyOutput("plot1",height ="20%",width="50%")
                          # plotlyOutput("plot1",height ="60vw",width="60vw")
                          )
                      
             ),
  f7Tab(title ="Evaluation",
          tabName ="Evaluation",
             
                      verbatimTextOutput("messageCheckData_2"),
                      div(id = "your_graph_id",
                        style=" overflow-y: scroll; position: relative",
                          # addSpinner(plotlyOutput("plot2",inline =F,height ="80vw"), 
                          #            spin = "bounce", color = "#007aff"
                          #              )
                          addSpinner(plotlyOutput("plot2",height ="100vw"),
                                     spin = "bounce", color = "#007aff"
                          )
                          # plotlyOutput("plot2",height ="20%",width="50%")
                          # plotlyOutput("plot2",inline =F,height ="20%",width="50%")
                          )
                      
               
             ),
  f7Tab(title ="Run Eval",
        # title ="Runnin Evaluation",
          tabName ="Runnin_Evaluation",
             
                      verbatimTextOutput("messageCheckData_3"),
                      div(id = "your_graph_id",
                        style=" overflow-y: scroll; position: relative",
                          # addSpinner(plotlyOutput("plot3",height ="80vw"), 
                          #            spin = "bounce", color = "#007aff"
                          # )
                          addSpinner(plotlyOutput("plot3",height ="100vw"),
                                     spin = "bounce", color = "#007aff"
                          )
                          # plotlyOutput("plot3",height ="20%",width="50%")
                          # plotlyOutput("plot3",height ="20%",width="50%")
                          )
                      
             )
  )


output_graphs2<-
f7Accordion(
    f7AccordionItem(title ="Sensitivity and PPV",
          # tabName ="Sensitivity_and_PPV",
             fluidRow(
               column(12,
                      verbatimTextOutput("messageCheckData_4"),
                      wellPanel(tableOutput("table1")))
                      
                      )
             ),
    f7AccordionItem(title ="Auto calibration outputs",
          # tabName ="Auto_calibration_outputs",
             fluidRow(
               verbatimTextOutput("messageCheckData_5"),
               column(12,wellPanel(tableOutput("table2")))
             )),
    f7AccordionItem(title ="Output files",
          # tabName ="Output_files",
          verbatimTextOutput("messageCheckData_6"),
                    uiOutput("output_files")                
    )  
  )

output_dis<-column(3,
  selectInput(inputId = "district",
            label = "District",
            choices = c(15,20,3),
            selected =4,
            multiple =F))

output_dis1<-"inputPanel(fluidRow(
             column(6,
                    selectInput(inputId = 'district_dB2',
                           label = 'District',
                   choices = 999,
                   selected =999,
                   multiple =F))))
                   "

output_dis2<-"inputPanel(
                  selectInput(inputId = 'district',
label = 'District',
choices = sel_districts(),
selected =sel_districts()[1],
multiple =F)
)"

dat_opts<- f7Block(title ="Data",
                 # tabName ="Data",
                    column(12,
                    shinydashboardPlus::box(width=12,
              # --------- fileInput -------
              # f7File('dat', 'choose file to upload', accept=c('.xls','.xlsx','.csv')),
              
              # fileInput('dat', 'choose file to upload', accept=c('.xls','.xlsx','.csv')),
              textInput("original_data_sheet_name", "Choice of sheet name for the original data", "Sheet1"),
              f7Checkbox("graph_per_district", 
                            "Specify graph per district/municipality option",value =TRUE),
              br(),
              
              
             #f7Checkbox("generating_surveillance_workbook",
                            #"Generate surveillance workbooks", value=FALSE),
              f7Checkbox("spline",
                            "Spline", value=FALSE),
              selectInput(inputId = "run_per_district",
                          label = "District codes",
                          choices = c(15,20,3,999),
                          selected =999,
                          multiple =T),
             f7Checkbox("Run_all",
                           "Run all districts",
                           value =F))
))

sel_vars<-f7Block(title ="Variables and Runnin",
                # tabName ="Variables_and_Runnin",
      
      column(12,
             shinydashboardPlus::box(width=12,
                     #selectInput('country_code', 'country code', 
                                 #c("XX"),
                                 #selected="XX", width="35%"),
                     #textInput("psswd", "8 digit password", "12345678"),
  selectInput("population",
              "Variable for annual total Population",
              "population",multiple =F),
  selectInput("number_of_cases", 
              "Variable for the weekly number of outbreak",
              "weekly_hospitalised_cases",multiple =F),
  selectInput("alarm_indicators", selected =c("rainsum","meantemperature"),
              "Alarm indicator(s)",
              choices=c("rainsum","meantemperature"),multiple =T),
  # when spline is selected show options to select varaibles
  
  conditionalPanel("input.spline",
  selectInput("spline_alarm_indicators", selected =c("rainsum","meantemperature"),
                               "Spline Alarm indicator(s)",
                               choices=c("rainsum","meantemperature"),multiple =T)),
  sliderInput("stop_runinYear", 
              "Specify the year the run-in period stops",
              value =2012,step =1,
              min=1990,max=2030,sep=''),
  sliderInput("stop_runinWeek", 
              "Specify the week the run-in period stops",
              value =52,step =1,
              min=52,max=52)
  )))


calib1<-                f7Block(column(12,
                        shinydashboardPlus::box(
                          width = 12,
                          sliderInput(
                            "outbreak_week_length",
                            #"Outbreak weeks to declare outbreak period/stop outbreak",
                            "Outbreak period",
                            min = 1,
                            max = 24,
                            value = 3,
                            step = 1,
                            ticks = F,
                            dragRange = F
                          ),
                          sliderInput(
                            "alarm_window",
                            "Alarm window size",
                            value = 3,
                            min = 1,
                            max = 24,
                            step = 1
                          ),
                          sliderInput(
                            "alarm_threshold",
                            #"Alarm threshold for alarm signal",
                            "Alarm threshold",
                            value = .12,
                            min = 0.0005,
                            max = 1,
                            step = 0.0001
                          )
                          ,
                          selectInput(
                            "season_length",
                            "Seasons in a year",
                            choices = c(1,2,3,4,6,12),
                            selected=1,multiple =F
                             )
                        )
                 )
)



calib2<-                 f7Block(column(12,
                        shinydashboardPlus::box(
                          width = 12,
                          sliderInput(
                            "z_outbreak",
                            #"Multiplier for standard deviation to vary  endemic channel",
                            "Z-outbreak",
                            value = 1.25,
                            min = 1,
                            max = 4,
                            step = 0.01
                          ),
                          sliderInput(
                            "outbreak_window",
                            "Outbreak window size",
                            value = 4,
                            min = 1,
                            max = 24,
                            step = 1
                          ),
                          sliderInput(
                            "prediction_distance",
                            #"Distance between current week and target week to predict an outbreak signal",
                            "Prediction Distance (time lag)",
                            value = 2,
                            min = 1,
                            max = 24
                          ),
                          sliderInput(
                            "outbreak_threshold",
                            #"Cut-off value to define the outbreak signal",
                            "Outbreak threshold",
                            
                            value = 0.75,
                            min = 0.00005,
                            max = 1,
                            step = 0.0001)
                        )
                ))
             
            

calib1_auto<-           column(12,
                        shinydashboardPlus::box(
                          width = 12,
                          sliderInput(
                            "outbreak_week_length",
                            "Outbreak weeks to declare outbreak period/stop outbreak",
                            min = 1,
                            max = 24,
                            value = c(2,6),
                            step = 1,
                            ticks = F,
                            dragRange = F
                          ),
                          sliderInput(
                            "alarm_window",
                            "Alarm window size",
                            value = c(2,6),
                            min = 1,
                            max = 24,
                            step = 1
                          ),
                          sliderInput(
                            "alarm_threshold",
                            "Alarm threshold for alarm signal",
                            value = c(0.05,0.6),
                            min = 0.0005,
                            max = 1,
                            step = 0.0001
                          ),
                          sliderInput(
                            "season_length",
                            "Seasons in a year",
                            value = c(52,52),
                            min = 1,
                            max = 52,
                            step = 1 )
                        )
                 )



calib2_auto<-column(12,
                        shinydashboardPlus::box(
                          width = 12,
                          sliderInput(
                            "z_outbreak",
                            "Multiplier for standard deviation to vary  endemic channel",
                            value = c(0.05,3),
                            min = 0.0001,
                            max = 4,
                            step = 0.001
                          ),
                          sliderInput(
                            "outbreak_window",
                            "Outbreak window size",
                            value = c(2,10),
                            min = 1,
                            max = 24,
                            step = 1
                          ),
                          sliderInput(
                            "prediction_distance",
                            "Distance between current week and target week to predict an outbreak signal",
                            value = c(3,12),
                            min = 1,
                            max = 24
                          ),
                          sliderInput(
                            "outbreak_threshold",
                            "Cut-off value to define the outbreak signal",
                            value = c(0.05,0.6),
                            min = 0.00005,
                            max = 1,
                            step = 0.0001)
                        )
                 )

# row_elements0 <- fluidRow(column(3,
#                                  f7Checkbox("getdata_ggdrive",
#                                             "Use data from ggdrive?",
#                                             value =F)),
#                           
#                     )

row_elements1.x<-fluidRow(column(3,
                               f7Checkbox("automate",
                                             "Automatic Calibration",
                                             value =F)),
                               
                        )

row_elements1<-fluidRow(column(3,
                               f7Checkbox("automate",
                                             "Automatic Calibration",
                                             value =F)),
                        
                        column(5,
                               selectInput(
                                 "iterations",
                                 "Auto iterations",
                                 choices = c(100,500,1000,5000,10000),
                                 selected=100,multiple =F
                               ))
                        
)


row_elements2<-fluidRow(     
  column(3,
    # h4("Dataset:"),
    # f7Tabs(style = "strong",
    #        animated = TRUE,
    #        swipeable = FALSE,
    #        
    #        f7Tab(title ="Dataset", 
    #              tabName ="Dataset",
    f7BlockTitle(title = "Dataset") %>% f7Align(side = "center"),
    
    
    # --------- fileInput -------
    div(class="checkboxBG",
      f7Checkbox("dat","Use demo data?",value =F)
    ),
    
                 f7Accordion(
                 
           
    f7AccordionItem(
      title = "Data",
      # open = TRUE,
      dat_opts
    ),
    f7AccordionItem(
      title = "Variables and Runnin",
      sel_vars
    ),
    f7AccordionItem(
      title = "calib1",
      calib1
    ),
    f7AccordionItem(
      title = "calib2",
      calib2
    ),
    
    hr(),
    
    )),
  
  column(7,
         # h4("Graph:"),
         # f7Tabs(style = "strong",
         #        animated = TRUE,
         #        swipeable = FALSE,
         #        
         #        f7Tab(title ="Graph", 
         #              tabName ="Graph",
         #              
         #               output_graphs
         #              )
         #        ),
         f7BlockTitle(title = "Output Graph") %>% f7Align(side = "center"),
         output_graphs,
         output_graphs2,
         output_dis
         ),
  column(1,
         actionButton('save_mode','Save Model',
                      style="color: forestgreen; background-color:grey(0.5);
                                 padding: 10px 15px; height: 80px; cursor: pointer;
                                 font-size: 20px; font-weight: 400;
                                 margin-bottom: 10rem;
                      "),
         style="margin-bottom: 10rem;"
  )
  )

#----------------------
# ยังไม่ได้แก้อันนี้
row_elements2_restricted<-fluidRow(     
  column(3,
         # div(class="scrollmenu",
         # f7Tabs(id="input_pan",
         #        style = "strong",
         #        animated = TRUE,
         #        swipeable = FALSE,
                
                  
                  f7AccordionItem(
                    title = "Data",
                    dat_opts
                  )
                  # f7Block(sel_vars),
                  #    f7AccordionItem(title ="calib1",f7Block(calib1)),
                  #    f7AccordionItem(title ="Calib2",f7Block(calib1))
                     
         ),
  
  column(8,output_graphs,
         output_dis)
)


# ----------- dashboad_elements_I  -------------
dashboad_elements_I<-f7Tab(# title = HTML("</br>Dashboard I"),
                           tabName ="Dashboard_I",
                            
                           icon = f7Icon("doc_chart_fill"),
                           active = TRUE,
                           scrollable = TRUE,
         fluidPage(
           style = "overflow-y: auto;" ,
           h3("Dashboard I", style = "text-align: center;"),
           #------------------------
           # # เพิ่มอันใหม่ ที่เป็น Get Data from Google drive ตรงนี้
           # h4("Get Data from Google drive"),
           # # row_elements0,
           # f7Checkbox("getdata_ggdrive",
           #            "Use data from ggdrive?",
           #            value =F),
           # div(
           #      style="display: flex;",
           #      h5("Data from: ", style="margin-right: 5px;"),
           #      f7Link(label = "google drive", href = "https://docs.google.com/spreadsheets/d/1P85nfciSua_wbMcwiDpMK6klFmIjSn2v0_143lNEBL8/edit#gid=2037739524")
           #      ),
           # uiOutput('dataTable'),
           # hr(),
           #------------------------
           row_elements1,    
           row_elements2
                        
)
 )               #actionButton("manual",icon=icon("refresh"),
                #"Manual Calibration", value=T),








dashboad_elements_restricted_I<-f7Tab(title = HTML("</br>Dashboard I"),
                                      tabName ="Dashboard_I",
                                       
                                      icon = f7Icon("doc_chart_fill"),
                                      active = TRUE,
                                      scrollable = TRUE,
                              fluidPage(
                                style = "overflow-y: auto;" ,
                                row_elements1,    
                                f7Accordion(row_elements2_restricted)
                                
                              )
)                    
         


#base_input<-"selectInput('District','District',choices =c(3,15,20,999),selected =999,multiple =F),

base_input<-"selectInput('year','Year',choices =2019:2030,selected =2019,multiple =F),
selectInput('week','Week',choices =2:52,selected =2,multiple =F),
numericInput('Cases','Weekly number of cases',value=NA),
numericInput('Population','Population',value=NA)"


## nest Risk mapping in dashboard II

## risk mapping elements

output_graphs_spat_Agg<-  
  
  f7Tabs(style = "strong",
         animated = TRUE,
         swipeable = FALSE,
    f7Tab(title ="Output Graph", 
          tabName ="Output_Graph",
          column(12,
                 f7Accordion(
                 
                 f7AccordionItem(title = "Spatial Plots",
                                 # tabName ="Spatial_Plots", 
                                 uiOutput("Error"), 
                                 uiOutput("Spat_Plot")  
                 )
                 ,
                 f7AccordionItem(title = "Time series",
                                 # tabName ="Time_series",
                                 uiOutput("Time_series_Plots")
                 ),
                 f7AccordionItem(title ="Risk maps",
                                 # tabName ="Risk_maps",
                                 fluidRow(
                                   column(12,tmapOutput("plot3_spat")
                                   )
                                 ))
                 )
            )
          )
  )
        
  # h4("Output Graph:"),
  


output_graphs_spat_point<-f7Tabs(  style = "strong",
                                   animated = TRUE,
                                   swipeable = FALSE,
  
  f7Tab(title ="Spatial Plots", 
        tabName ="Spatial_Plots", 
           fluidRow(
           uiOutput("Error"), 
           column(12,tmapOutput("Spat_Plot"))
           )
  )
  ,
  f7Tab(title ="Risk maps",
        tabName ="Risk_maps",

           fluidRow(
             uiOutput("plot3_spat")
            
           ))
)

output_year_spat<-column(3,
                         sliderInput(inputId = "Year_plot_spat",
                                     label = "Year",
                                     min = 2008,
                                     max=2030,
                                     value =2012,
                                     sep='',
                                     step=1),
                         sliderInput(inputId = "Week_plot_spat",
                                     label = "Week",
                                     min = 1,
                                     max=52,
                                     step=1,
                                     sep='',
                                     value =35),
                         div(class = "mb-10"),
)


dat_opts_spat<- f7Tab(title ="Spatial data Upload", 
                      tabName ="Spatial_data_Upload",
                         column(12,
                                shinydashboardPlus::box(width=12,
                                        ##choose point/ lat long data
                                        
                                        fileInput('shape_file', 'District sub-district boundary file (.shp file)',
                                                  accept=c('.shp','.dbf','.shx','.prj'),
                                                  multiple =T),
                                        ## choose aggregated or point data
                                        
                                        selectInput("spat_Input_Type", selected =c("sub_district"),
                                                    "Geographic data input (point or aggregated)",
                                                    choices=c("point (LatLon)","sub_district"),multiple =F),
                                        
                                        fileInput('dat_spat', 'Choose surveillance data with spatial inputs', accept=c('.xls','.xlsx','.csv')),
                                        uiOutput("Spat_error"),
                                        selectInput("population_spat",
                                                    "Variable for annual total Population",
                                                    "population",multiple =F),
                                        selectInput("number_of_cases_spat", 
                                                    "Variable for the weekly number of outbreak",
                                                    "weekly_hospitalised_cases",multiple =F),
                                        selectInput("alarm_indicators_spat", selected =c("rainsum","meantemperature"),
                                                    "Alarm indicator(s)",
                                                    choices=c("rainsum","meantemperature"),multiple =T),
                                        # when spline is selected show options to select variables
                                        
                                        sliderInput("stop_runinYear_spat", 
                                                    "Specify the year the run-in period stops",
                                                    value =2012,step =1,
                                                    min=1990,max=2030,sep=''),
                                        sliderInput("stop_runinWeek_spat", 
                                                    "Specify the week the run-in period stops",
                                                    value =52,step =1,
                                                    min=1,max=52)
                                        
                                        
                                )
                         ))



row_elements_spat<-fluidRow(     
  column(4,
         f7Tabs(id="input_pan_spat",
                style = "strong",
                animated = TRUE,
                swipeable = FALSE,
                     dat_opts_spat
                     # sel_vars
         )),
  
  column(8,
         uiOutput("spat_Display")
         ,
         output_year_spat)
)



dashboad_elements_Risk_mapping<-f7AccordionItem(title = "Risk mapping",
                                      # tabName ="Risk_mapping",
                                         fluidPage(
                                           row_elements_spat    
                                           
                                         )
)              



# ----------- dashboad_elements_II  -------------
dashboad_elements_II<-f7Tab(#title = HTML("</br>Dashboard II"),
                            tabName ="Dashboard_II",
                            style = "overflow-y: auto;" ,
                            icon = f7Icon("doc_text_fill"),
                            # icon = f7Icon("doc_text_search"),
                            h3("Dashboard II", style = "text-align: center;"),
                             column(3,
                                    f7Tabs(  
                                      style = "strong",
                                      animated = TRUE,
                                      swipeable = FALSE,
                                      f7Tab(title ="Parameters",
                                            tabName ="Parameters",
                                            wellPanel(tags$h3("Alarm Indicators:"),
                                              uiOutput('a_vars')),
                                              wellPanel(br(),
                                                
                                               tableOutput("alr_vars")),
                                            wellPanel(tags$h3("Spline Indicators:"),
                                                      uiOutput('s_vars')))
                                      
                                    ),
                                    hr(),
                                    
                             ),
                             column(9,
                                    f7Accordion(
                                      style = "strong",
                                      animated = TRUE,
                                      swipeable = FALSE,
                                      f7AccordionItem(title="Input Data", 
                                            # tabName ="Input_Data",
                                          fluidPage(fluidRow(uiOutput("input_dataset")),
                                                    
                                                      inputPanel(
                                                        fluidRow(
                                                      column(3,
                                                      actionButton('ins_dat','Update table'))),
                                                      column(3,offset =6,
                                                             actionButton('Refresh_DB','Refresh'))
                                                      ),
                                               DT::dataTableOutput("data_dis")
                                               )),
                                      
                                      f7AccordionItem(title ="Prediction tables",
                                            # tabName ="Prediction_tables",
                                                      # inputPanel(uiOutput("sel_diss")),
                                                      DT::dataTableOutput("pred_dis")
                                                        ),
                                      
                                      f7AccordionItem(title ="Outbreak",
                                            # tabName ="Outbreak",
                                                        #inputPanel(uiOutput("sel_diss")),
                                                        plotOutput("db2_plot1",width ="700px",height ="320px")
                                                        ),
                                      
                                      f7AccordionItem(title ="Probability",
                                            tabName ="Probability",
                                             #inputPanel(uiOutput("sel_diss1")),
                                             plotOutput("db2_plot2",width ="700px",height ="320px")
                                    ),
                                    
                                    f7AccordionItem(title ="Outbreak and Probability",
                                          # tabName ="Outbreak_and_Probability",
                                             #inputPanel(uiOutput("sel_diss1")),
                                             plotOutput("db2_plot3",width ="700px",height ="320px")
                                             ),
                                    
                                    f7AccordionItem(title ="Response",
                                          # tabName ="Response",
                                             #inputPanel(uiOutput("sel_diss1")),
                                             plotOutput("db2_plot4")
                                             ),
                                    dashboad_elements_Risk_mapping,
                                    div(class = "mb-10")
                                               
                                    )          
                                    
                                    
                             )
                            
                  )                      

# ----------- dashboad_elements_III  -------------
dashboad_elements_III<-f7Tab(#title = HTML("</br>Help"),
                             tabName ="Help",
                             style = "overflow-y: auto;" ,
                             h3("Help", style = "text-align: center;"),
                             icon = f7Icon("question_circle_fill"),
                                tags$br(),
                                tags$br(),
                                tags$div(
                                  HTML(paste(tags$strong("Early Warning and Response System for Dengue Outbreaks: Operational Guide using the web-based Dashboard"), 
                                             tags$a(href="https://drive.google.com/file/d/1MJWocIyu3Ecdy950w0Z2d9i50hceEFA1/view?usp=sharing", target="_blank", tags$br(),tags$b(" Operational Guide")),
                                             sep = ""))
                                ),
                               # tags$div(
                                #  HTML(paste(tags$strong("Addendum: Automatised Early Warning And Respons System"), 
                                 #            tags$a(href="https://drive.google.com/open?id=1VCZbxO6Qfy7oyt_2O1T_XGa-VNhjaCsF", target="_blank", tags$br(),tags$b("Automatised Early Warning And Respons System")),
                                 #            sep = ""))
                                #),
                                tags$div(
                                  HTML(paste(tags$strong("Demo Excel workbook"), 
                                             tags$a(href="https://drive.google.com/file/d/1ujlq5oZVSF8dg7A3KN6Csw-5LsEWqYzF/view?usp=sharing", target="_blank", tags$br(),tags$b("Demo data")),
                                             sep = ""))),
                                  
                                  tags$div(
                                    HTML(paste(tags$strong("Risk mapping demo files"), 
                                               tags$a(href="https://drive.google.com/drive/folders/1GXZ6vwEONEqxvUjLB4QMG0aduKkyIGIF?usp=sharing", target="_blank", tags$br(),tags$b("Risk mapping demo files")),
                                               sep = ""))),
                                  
                              
                                tags$br(),
                                tags$br()
                                
                                
                                
)  

# ----------- dashboad_elements_IV  -------------
dashboad_elements_IV<-f7Tab(#title = HTML("</br>R scripts"),
                            tabName ="R_scripts_and_Files",
                            style = "overflow-y: auto;" ,
                            h3("R scripts", style = "text-align: center;"),
                            icon = f7Icon("folder_fill"),
                               tags$br(),
                               tags$br(),
                               tags$div(
                                 HTML(paste(tags$strong("R scripts and Files"), 
                                            tags$a(href="https://umeauniversity-my.sharepoint.com/:f:/g/personal/odse0001_ad_umu_se/EpwpHBzDg2pIr6pZPIMtEnoBvVJUHSL2NZ97RoOQi6sx7A?e=225F2c", target="_blank", tags$br(),tags$b("App R scripts and files")),
                                            sep = ""))
                               )
                               
                               
)  

# ----------- admin page  -------------

add_user<-f7Tab(title ="Add users",
                tabName ="Add_users",
                   fluidPage(fluidRow(
                     inputPanel(textInput("First_name","First Name"),
                                textInput("Last_name","Last name"),
                                textInput("users_name","User name"),
                                passwordInput("pass_word","Password"),
                                textInput("email","email address"),
                                selectInput(inputId = 'role',
                                            label = 'Role',
                                            choices = c("Admin","District Manager"),
                                            selected ="District Manager",
                                            multiple =F),
                                conditionalPanel('input.role=="District Manager"',
                                                 selectInput(inputId = 'district_manage',
                                                             label = 'District access',
                                                             choices =c(9999,99999) ,
                                                             selected =9999,
                                                             multiple =T)),
                                actionButton("Enter_user","Add user",
                                             style="color: white; background-color:#3c8dbc;
                                 padding: 10px 15px; width: 150px; cursor: pointer;
                                 font-size: 18px; font-weight: 300; margin-bottom: 10rem;")
                     ))),
                   fluidRow(
                     column(8,
                            DT::dataTableOutput("users_dat")),
                     column(4,
                            DT::dataTableOutput("users_districts"))
                   ))


remove_user<-f7Tab(title ="Delete users",
                   tabName ="Delete_users",
                   fluidPage(
                     inputPanel(fluidRow(column(10,
                                selectInput(inputId = 'user_de',
                                            label = 'Users to delete',
                                            choices = "john doe",
                                            selected ="john doe",
                                            multiple =T,width =unit(5,'in'))))),
                     
                     fluidRow(column(4,
                            actionButton("Delete_user","Delete",
                                         style="color: white; background-color:#3c8dbc;
                                 padding: 10px 15px; width: 150px; cursor: pointer;
                                 font-size: 18px; font-weight: 300;"))
                   )))
                   


# admin_page<-f7Tab(#title =HTML("</br>Admin page"),
#                   tabName ="Admin_page",
#                   style = "overflow-y: auto;" ,
#                   h3("Admin Page", style = "text-align: center;"),
#                   icon = f7Icon("gear_alt_fill"),
#                      f7Tabs(
#                        style = "strong",
#                        animated = TRUE,
#                        swipeable = FALSE,
#                         add_user,
#                         remove_user)
# )

#------ UI Main ------------

ui_yes<-f7TabLayout(
  # tags$h2("My secure application"),
  # verbatimTextOutput("auth_output"),
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")  # import css file
    
  ),

  fluidRow(
  column(3,offset =5,
         uiOutput("title_txt")),
  column(2,offset =11,
         uiOutput("logged_in_user"),
         uiOutput('logout'))
),
  f7Tabs(
        id = "tabset",
         # id = "tabdemo",
         # style = "segmented",
         animated = TRUE,
         swipeable = FALSE,
                      
                       dashboad_elements_I,
                       
                       dashboad_elements_II,
                      
                       # admin_page,
                       
                       #dashboad_elements_Risk_mapping,
                       
                       dashboad_elements_III,
                       
                       dashboad_elements_IV
           
           
           
           # admin page
           
)


,
navbar = f7Navbar(
  title = "EWARS Dashboard on mobile",
  subtitle = "The Early Warning and Response System (EWARS) for Dengue Outbreaks",
  hairline = FALSE,
  shadow = TRUE
))

ui_yes_Restricted<-fluidPage(fluidRow(
  column(3,offset =5,
         uiOutput("title_txt")),
  column(2,offset =11,
         uiOutput("logged_in_user"),
         uiOutput('logout'))
),
f7Tabs(style = "segmented",
       animated = TRUE,
       swipeable = FALSE,
       
                    dashboad_elements_restricted_I,
                    
                    dashboad_elements_II,
                   # dashboad_elements_Risk_mapping,
                    
                    dashboad_elements_III,
                   
                   dashboad_elements_IV
                    
                    # admin page
                    
)


)

## UI nologin

UI_NO_login<-fluidPage(fluidRow(
  column(3,offset =5,
         uiOutput("title_txt")),
  #column(2,offset =11,
         #uiOutput("logged_in_user"),
         #uiOutput('logout'))
),
f7Tabs( style = "segmented",
       animated = TRUE,
       swipeable = FALSE,
       
                    dashboad_elements_I,
                    
                    dashboad_elements_II,
                    
                    # admin_page,
                    
                    #dashboad_elements_Risk_mapping,
                    
                    dashboad_elements_III,
                    
                    dashboad_elements_IV
                    
                    # admin page
                    
)


)

