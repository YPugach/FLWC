/**
 * Created by e.pugach on 19.02.20.
 */
@IsTest
private class LeadTriggerTest {
    @IsTest
    static void beforeInsertOneLead() {
        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12);
        Lead lead = TestDataGenerator.createLead();
    }

@IsTest
    static void beforeInsertInvalidLead() {
        try{
            Lead lead = TestDataGenerator.createLeadWithInvalidSource();
        }catch (System.DmlException e){
            System.assert(e.getMessage().contains('Please select an existing campaign source'));
        }
    }

    @IsTest
    static void beforeInsertLeads() {
        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12);
        Test.startTest();
        List<Lead> leads = TestDataGenerator.createLeadsWithSource(250);
        Test.stopTest();
    }
    @IsTest
    static void beforeInsertInvalidLeads() {

        Test.startTest();
        try{
            List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12);
            List<Lead> leads = TestDataGenerator.createLeadsWithInvalidSource(250);
        }catch (System.DmlException e){
            System.assert(e.getMessage().contains('Please select an existing campaign source'));
        }
        Test.stopTest();
    }

    @IsTest
    static void beforeUpdateInvalidLead() {
        Test.startTest();
        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12);
        Lead lead = TestDataGenerator.createLead();
        try{
            lead.LeadSource = 'Twitter';
            update lead;
        }catch (System.DmlException e){
            System.assert(e.getMessage().contains('Please select an existing campaign source'));
        }
        Test.stopTest();

    }
//    @IsTest
//    static void afterInsertLead() {
//        Test.startTest();
//        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12);
//        Lead lead = TestDataGenerator.createLead();
//        Campaign camp = [SELECT Name, Id FROM Campaign WHERE Parent.Name =:lead.LeadSource AND StartDate<:lead.CreatedDate.date() AND EndDate> :lead.CreatedDate.date()];
//        CampaignMember cm = [SELECT Name, Id, LeadId, CampaignId  FROM CampaignMember WHERE LeadId =:lead.Id];
//        System.assertEquals(cm.CampaignId,camp.Id );
//        Test.stopTest();
//
//    }
}