/**
 * Created by e.pugach on 19.02.20.
 */

public with sharing class TestDataGenerator {
    public static Lead createLead() {
        Lead lead = new Lead(
                LastName = getRandomString(),
                Company = getRandomString(),
                LeadSource = 'Facebook',
                CreatedDateTime__c = System.now());
        insert lead;
        return lead;
    }
    public static Lead createLeadWithInvalidSource() {
        Lead lead = new Lead(
                LastName = getRandomString(),
                Company = getRandomString(),
                LeadSource = 'Twitter',
                CreatedDateTime__c = System.now());
        insert lead;
        return lead;
    }


    public static List<Lead> createLeadsWithSource(Integer count){
        List<Lead> leads = new List<Lead>();
        for(Integer i =0;i<count;i++){
            Lead l = new Lead(
                    LastName = getRandomString(),
                    Company = getRandomString(),
                    LeadSource = 'Facebook',
                    CreatedDateTime__c = System.now());
            leads.add(l);
        }
        insert leads;
        return leads;
    }

    public static List<Lead> createLeadsWithInvalidSource(Integer count){
        List<Lead> leads = new List<Lead>();
        for(Integer i =0;i<count;i=i+2){
            Lead l1 = new Lead(
                    LastName = getRandomString(),
                    Company = getRandomString(),
                    LeadSource = 'Facebook',
                    CreatedDateTime__c = System.now());
            leads.add(l1);
            Lead l2 = new Lead(
                    LastName = getRandomString(),
                    Company = getRandomString(),
                    LeadSource = 'Twitter',
                    CreatedDateTime__c = System.now());
            leads.add(l2);
        }
        insert leads;
        return leads;
    }

    public static Campaign createCampaign(String nam){
        Campaign camp = new Campaign(
                Name = nam
        );
        insert camp;
        return camp;
    }
     public static List<Campaign> createCampaignWithChildCampaigns(Integer month, String nam){
         Campaign camp = createCampaign(nam);
         List<Campaign> childCampaigns = new List<Campaign>();
         for(Integer i=1; i<=month;i++){
             Campaign child = new Campaign(
                     Name = nam+'_'+i+'_2020',
                     ParentId = camp.Id,
                     StartDate = Date.newInstance(2020,i,1),
                     EndDate = Date.newInstance(2020,i,29)
             );
             childCampaigns.add(child);
         }
         insert childCampaigns;
         return childCampaigns;
     }


    public static String getRandomString() {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        // Name field limited by 40 chars
        while (randStr.length() < 20) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx + 1);
        }
        return randStr;
    }
}