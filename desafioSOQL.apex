//Receber data limite e tipo do evento

//

public static Map<String, List<Evento__c>> getNextEvents(Date maxDate,Set<String> eventTypes){
      
      //Bando de dados do objeto evento
      List<Evento__c> eventoList = [
          SELECT Id,Name, Tipo__c,Data__c
          FROM Evento__c
          WHERE Ativo__c = true AND Tipo__c IN: eventTypes AND Data__c >: maxDate
      ];

    // instancia do map 
    Map<String,List<Evento__c>> eventoTypesAndEvents = new Map<String,List<Evento__c>>();
    
    // adicionar valores ao map
    for(Evento__c evento : eventoList){
        if(eventoTypesAndEvents.containsKey(evento.Tipo__c)){
            eventoTypesAndEvents.get(evento.Tipo__c).add(evento);

        }else{
            eventoTypesAndEvents.put(evento.Tipo__c, new List<Evento__c>{
                evento
            });
        }
    }

    return eventoTypesAndEvents;


}

//public static Date 

public static void execute(){

    Set<String> typesEventSet = new Set<String>();

    List<Evento__c> eventoList = [
        SELECT Tipo__c
        FROM Evento__c
    ];

    for(Evento__c evento : eventoList){
      typesEventSet.add(evento.Tipo__c)  ;
    }
	System.debug(' typesEventSet ===> '+ typesEventSet);
    Date maxDateExecute = Date.newInstance(2022,01,06);
    System.debug(' maxDateExecute ===> '+ maxDateExecute);
    
    

    Map<String,List<Evento__c>> showTypesAndEvents = getNextEvents(maxDateExecute,typesEventSet);
	System.debug(' showTypesAndEvents ==> '+showTypesAndEvents);
    for(String typeEventExecute : showTypesAndEvents.keySet()){
        System.debug(' tipo do evento ==> '+ typeEventExecute);
        List<Evento__c> nameEventsExecute = showTypesAndEvents.get(typeEventExecute);
        System.debug(' Eventos ==> '+nameEventsExecute);
    }


}