public with sharing class createLeadLWC {

//    public class leadd {
//        String FirstN;
//        String LastN;
//        String Em;
//        String Comp;
//    }

//        First (simple) variant to parsing in one row
//    @AuraEnabled
//    public static void insertLead(String jsonString) {
//        List<Lead> leads =(List<Lead>) System.JSON.deserialize(jsonString, List<Lead>.class);
//        insert leads;
//    }


//        Second variant to parsing with using Parser to parsing any JSONData
//    @AuraEnabled
//    public static void insertLead(String jsonString) {
//
//        List<Lead> leads = new List<Lead>();
//        JSONParser parser = JSON.createParser(jsonString);
//        while (parser.nextToken() != null) {
//            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
//                while (parser.nextToken() != null) {
//                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
//                        Lead le = (Lead)parser.readValueAs(Lead.class);
//                        Lead leadobj = new Lead();
//                        leadobj.FirstName=le.FirstName;
//                        leadobj.LastName=le.LastName;
//                        leadobj.Company=le.Company;
//                        leadobj.Email=le.Email;
//                        leads.add(leadobj);
//                    }
//                }
//            }
//        }
//        insert leads;
//    }

//        Third variant to parsing without type of data.
      @AuraEnabled
      public static void insertLead(String jsonString) {

        List<Lead> leads = new List<Lead>();
        List<Object> leadObjects = (List<Object>) JSON.deserializeUntyped(jsonString);
         for (Object l :leadObjects) {
             Map<String, Object> leadAttributes = (Map<String, Object>)l;
             Lead le = new Lead();
             String firstN =(String) leadAttributes.get('firstName');
             le.FirstName = firstN;
             String lastN =(String) leadAttributes.get('lastName');
             le.LastName = lastN;
             String comp =(String) leadAttributes.get('company');
             le.Company = comp;
             String ema = (String) leadAttributes.get('email');
             le.Email = ema ;
             leads.add(le);
         }
          insert leads;
      }
}