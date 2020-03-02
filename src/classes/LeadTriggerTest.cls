/**
 * Created by e.pugach on 19.02.20.
 */
@IsTest
private class LeadTriggerTest {
    @IsTest
    static void checkInsertValidLeadSourceTest() {
        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12, 'Facebook');
        Lead lead = TestDataGenerator.createLead();
    }

@IsTest
    static void checkInsertInvalidLeadSourceTest() {
        try{
            Lead lead = TestDataGenerator.createLeadWithInvalidSource();
        }catch (System.DmlException e){
            System.assert(e.getMessage().contains('Please select an existing campaign source'));
        }
    }

    @IsTest
    static void checkInsertValidLeadSourcesTest() {
        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12, 'Facebook');
        Test.startTest();
        List<Lead> leads = TestDataGenerator.createLeadsWithSource(250);
        Test.stopTest();
    }
    @IsTest
    static void checkInsertInvalidLeadSourcesTest() {

        Test.startTest();
        try{
            List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12, 'Facebook');
            List<Lead> leads = TestDataGenerator.createLeadsWithInvalidSource(250);
        }catch (System.DmlException e){
            System.assert(e.getMessage().contains('Please select an existing campaign source'));
        }
        Test.stopTest();
    }

    @IsTest
    static void updateCampaignMembersTest() {
        Test.startTest();
        List<Campaign> childCampaigns = TestDataGenerator.createCampaignWithChildCampaigns(12, 'Facebook');
        Lead lead = TestDataGenerator.createLead();
        try{
            lead.LeadSource = 'Twitter';
            update lead;
        }catch (System.DmlException e){
            System.assert(e.getMessage().contains('Please select an existing campaign source'));
        }
        Test.stopTest();

    }
    @IsTest
    static void createNewCampaignMembersTest() {
        Test.startTest();
        List<Campaign> childCampaigns1 = TestDataGenerator.createCampaignWithChildCampaigns(12,'Facebook');
        List<Campaign> childCampaigns2 = TestDataGenerator.createCampaignWithChildCampaigns(12,'Instagram');
        Lead lead = TestDataGenerator.createLead();
        lead.LeadSource = 'Instagram';
        update lead;
        CampaignMember cm = [SELECT Name, Id, LeadId, CampaignId  FROM CampaignMember WHERE LeadId =:lead.Id ];
        System.assertEquals(cm.CampaignId,childCampaigns2[2].Id );
        Test.stopTest();

    }
}