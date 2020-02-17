public with sharing class createLeadLWC {
    public List<Lead> leads { get; set;}

//    public class leadd {
//        String FirstN;
//        String LastN;
//        String Em;
//        String Comp;
//    }
    @AuraEnabled
    public static void insertLead(String jsonString) {
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
        List<Lead> leads =(List<Lead>) System.JSON.deserialize(jsonString, List<Lead>.class);
//        for(Map<String,String> ld :lds){
//            Lead l = new Lead();
//            l.FirstName = ld.get('firstname');
//            l.LastName = ld.get('lastname');
//            l.Company = ld.get('company');
//            l.Email = ld.get('email');
//            leads.add(l);
//        }
        insert leads;

    }
}