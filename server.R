shinyServer(function(input, output) {
    
    output$lineplot <- renderPlot({
        if (input$metric==type[1]){
            met <- vars[1]
        }
        else if (input$metric==type[2]){
            met <- vars[2]
        }
        else if (input$metric==type[3]){
            met <- vars[3]
        }
      else met <- NA 
  animals <- c()
      if (animal_list[1] %in% input$animal){
        animals <- append(animals,"BEEF")
      }
  if (animal_list[2] %in% input$animal){
    animals <- append(animals,"PIG")
  }
  if (animal_list[3] %in% input$animal){
    animals <- append(animals,"POULTRY")
  }
        temp <- meat%>%select(c(1,2,6),met)%>%
          filter(LOCATION %in% input$countries,
                Type_of_Animal  %in% animals,
                TIME>=input$timerange[1] & TIME<=input$timerange[2])
        
      g <-  ggplot(temp)#+geom_line(aes_string(x="TIME",y=met,color="LOCATION",linetype='Type_of_Animal'))
      
     #  if (length(input$animal)==1 && length(input$countries)==1){
     #    g <- g+geom_line(aes_string(x="TIME",y=met,color='LOCATION',linetype='Type_of_Animal'))
     #  }
     #   else if (length(input$animal)>1 && length(input$countries)>1){
     #    g <- g+geom_line(aes_string(x="TIME",y=met,color="LOCATION",linetype='Type_of_Animal'))
     #  }
     #   else if (length(input$animal)>1 && !length(input$countries)>1){
     #    g <- g+geom_line(aes_string(x="TIME",y=met,color='Type_of_Animal',linetype="LOCATION"))
     #  }
     #  else if (!length(input$animal)>=2 && length(input$countries)>=2){
     #    g <- g+geom_line(aes_string(x="TIME",y=met,color="LOCATION",linetype='Type_of_Animal'))
     # }
     #  else g <- g+geom_line(aes_string(x="TIME",y=met))
      if (length(input$countries)>0 &length(input$animal)>0 ){

      if (length(input$animal)>1 & !length(input$countries)>1){
        g <- g+geom_line(aes_string(x="TIME",y=met,color='Type_of_Animal',linetype="LOCATION"))+
          scale_linetype_discrete(name="Location")+#,breaks=input$countries[!is.na(input$countries) & !is.na(input$animal)],labels=input$countries[!is.na(input$countries) & !is.na(input$animal)])+
          scale_color_discrete(name="Type of Animal")+#,breaks=input$animal)+
          guides(color = guide_legend(order = 1),linetype = guide_legend(order = 2))

      }
      
      
      # else {
      #   g <- g+geom_line(aes_string(x="TIME",y=met,color="LOCATION",linetype='Type_of_Animal'))+
      #     scale_color_discrete(name="Location",breaks=input$countries[!is.na(input$countries) & !is.na(input$animal)],labels=input$countries[!is.na(input$countries) & !is.na(input$animal)])+
      #     scale_linetype_discrete(name="Type of Animal")#,breaks=input$animal[!is.na(input$countries) & !is.na(input$animal)],labels=input$animal[!is.na(input$countries) & !is.na(input$animal)])+
      #     guides(color = guide_legend(order = 1),linetype = guide_legend(order = 2))
      # }
      
      else {
        g <- g+geom_line(aes_string(x="TIME",y=met,color="LOCATION",linetype='Type_of_Animal'))+
          scale_color_discrete(name="Location")+#,breaks=input$countries[!is.na(input$countries) & !is.na(input$animal)],labels=input$countries[!is.na(input$countries) & !is.na(input$animal)])+
          scale_linetype_discrete(name="Type of Animal")+#,breaks=input$animal[!is.na(input$countries) & !is.na(input$animal)],labels=input$animal[!is.na(input$countries) & !is.na(input$animal)])+
        guides(color = guide_legend(order = 1),linetype = guide_legend(order = 2))
        print(input$animal)
        print(input$countries)
        print(head(meat))
      }
      g <- g+theme_minimal()+xlab("Year")+ylab(input$metric)
      
      g
      }
       })
    
    # fix if animals >1
    # add total category to data
    
})


    