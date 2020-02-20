/**
 * Created by e.pugach on 20.02.20.
 */

public with sharing class LeadTriggerHandler {
    public static void beforeInsert(List<Lead> newLeads){
        checkValidLeadSource(newLeads);
    }

    public static void beforeUpdate(List<Lead> newLeads){
        checkValidLeadSource(newLeads);
    }

    public static void afterInsert(List<Lead> newLeads){
        createCampaignMembers(newLeads);
    }

    public static void afterUpdate(List<Lead> newLeads, List<Lead> oldLeads){
        createCampaignMembers(newLeads);
        deleteOldCampaignMembers(oldLeads);
    }

    public static void checkValidLeadSource(List<Lead> leads){
        Set<String> leadSourceStrings= generaSetSources(leads);

        Set<Campaign> campaigns = new Set<Campaign>([SELECT Name, Id FROM Campaign WHERE Campaign.Name = :leadSourceStrings]);
        for (Lead l : leads) {
            if (campaigns.size() < leadSourceStrings.size()) {
                l.addError('Please select an existing campaign source');
            }
        }
    }

    public static void createCampaignMembers(List<Lead> leads){
        List<CampaignMember> campaignMembers =new List<CampaignMember>();
        List<String> leadSources = new List<String>();
        Map<Lead,Date> dates = new Map<Lead,Date>();
        for (Lead l : leads){
            leadSources.add(l.LeadSource);
            dates.put(l, l.CreatedDate.date());
        }
        Set<String> leadSourceStrings = new Set<String>();
        leadSourceStrings.addAll(leadSources);

        Map<Id,Campaign> parentCampaigns = new Map<Id,Campaign>([SELECT Name, Id FROM Campaign WHERE Name=:leadSourceStrings]);

        List<Campaign> realChildCampaigns =[SELECT Name, Id, Parent.Name, StartDate, EndDate FROM Campaign WHERE ParentId =:parentCampaigns.keySet()];


        for(Lead l :leads){
            CampaignMember cm = new CampaignMember();
            for(Campaign c :realChildCampaigns){
                if (c.StartDate<l.CreatedDate.date() && c.EndDate > l.CreatedDate.date() && c.Parent.Name == l.LeadSource){
                    cm.LeadId=l.Id;
                    cm.CampaignId=c.Id;
                    campaignMembers.add(cm);
                }
            }
        }
        insert campaignMembers;
    }
    public static void deleteOldCampaignMembers(List<Lead> oldLeads){
        Set<String> leadSourceStrings= generaSetSources(oldLeads);
        List<CampaignMember> campaignMembers = [SELECT Id, Name FROM CampaignMember WHERE LeadId= :oldLeads AND Campaign.Parent.Name=:leadSourceStrings];
        delete campaignMembers;
    }

    public static Set<String> generaSetSources(List<Lead> leads){
        List<String> leadSources = new List<String>();
        for (Lead l : leads){
            leadSources.add(l.LeadSource);
        }
        Set<String> leadSourceStrings = new Set<String>();
        leadSourceStrings.addAll(leadSources);
        return  leadSourceStrings;
    }

}