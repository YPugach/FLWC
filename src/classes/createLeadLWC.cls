public with sharing class createLeadLWC {
    @AuraEnabled
    public static void insertLead(String jsonString) {
        List<Lead> leads = new List<Lead>();
        JSONParser parser = JSON.createParser(jsonString);
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        Lead le = (Lead)parser.readValueAs(Lead.class);
                        Lead leadobj = new Lead();
                        leadobj.FirstName=le.FirstName;
                        leadobj.LastName=le.LastName;
                        leadobj.Company=le.Company;
                        leadobj.Email=le.Email;
                        leads.add(leadobj);
                    }
                }
            }
        }
        insert leads;
    }
}