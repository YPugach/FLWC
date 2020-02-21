/**
 * Created by e.pugach on 20.02.20.
 */

public with sharing class LeadTriggerHandler {
    public static void beforeInsert(List<Lead> newLeads) {
        checkValidLeadSource(newLeads);
    }

    public static void beforeUpdate(List<Lead> newLeads) {
        checkValidLeadSource(newLeads);
    }

    public static void afterInsert(List<Lead> newLeads) {
        createCampaignMembers(newLeads);
    }

    public static void afterUpdate(List<Lead> newLeads, List<Lead> oldLeads) {
        createCampaignMembers(newLeads);
        deleteOldCampaignMembers(oldLeads);
    }

    public static void checkValidLeadSource(List<Lead> leads) {
        Set<String> leadSourceStrings = getSourcesSet(leads);

        Set<Campaign> campaigns = new Set<Campaign>([SELECT Name, Id FROM Campaign WHERE Campaign.Name = :leadSourceStrings]);
        for (Lead l : leads) {
            if (campaigns.size() < leadSourceStrings.size()) {
                l.addError('Please select an existing campaign source');
            }
        }
    }

    public static void createCampaignMembers(List<Lead> leads) {
        List<CampaignMember> campaignMembers = new List<CampaignMember>();
        Set<String> leadSourceStrings = getSourcesSet(leads);

        Map<Id, Campaign> parentCampaigns = new Map<Id, Campaign>([SELECT Name, Id FROM Campaign WHERE Name = :leadSourceStrings]);

        List<Campaign> realChildCampaigns = [SELECT Name, Id, Parent.Name, StartDate, EndDate FROM Campaign WHERE ParentId = :parentCampaigns.keySet() ORDER BY StartDate];

        Map<String, List<Campaign>> parentChildren = new Map<String, List<Campaign>>() ;

        for (Campaign c : parentCampaigns.values()) {
            parentChildren.put(c.Name, new List<Campaign>());
        }
        for (Campaign c : realChildCampaigns) {
            parentChildren.get(c.Parent.Name).add(c);
        }

        for (Lead l : leads) {
            CampaignMember cm = new CampaignMember();
            cm.LeadId = l.Id;
            if (parentChildren.containsKey(l.LeadSource)) {
                cm.CampaignId = parentChildren.get(l.LeadSource)[l.CreatedDate.month() - 1].Id;
                campaignMembers.add(cm);
            }
        }
        insert campaignMembers;
    }

    public static void deleteOldCampaignMembers(List<Lead> oldLeads) {
        Set<String> leadSourceStrings = getSourcesSet(oldLeads);
        List<CampaignMember> campaignMembers = [SELECT Id, Name FROM CampaignMember WHERE LeadId = :oldLeads AND Campaign.Parent.Name = :leadSourceStrings];
        delete campaignMembers;
    }

    public static Set<String> getSourcesSet(List<Lead> leads) {
        Set<String> leadSourceStrings = new Set<String>();
        for (Lead l : leads) {
            leadSourceStrings.add(l.LeadSource);
        }
        return leadSourceStrings;
    }

//    public class CampaignWrapper implements Comparable{
//        public Campaign camp;
//        public Integer monthNumber;
//
//        public CampaignMember (Campaign camp) {
//            this.camp = camp;
//            this.monthNumber = camp.CreatedDate.month();
//        }
//    }
}