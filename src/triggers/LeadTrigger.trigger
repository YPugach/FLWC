/**
 * Created by e.pugach on 18.02.20.
 */

trigger LeadTrigger on Lead (before insert, before update, after insert, after update ) {
    if (Trigger.isBefore){
        if(Trigger.isInsert) {

            List<String> leadSources = new List<String>();
            for (Lead l : Trigger.new){
                leadSources.add(l.LeadSource);
            }
            Set<String> leadSourceStrings = new Set<String>();
            leadSourceStrings.addAll(leadSources);
            System.debug(leadSourceStrings);
            //use Maps
            Set<Campaign> campaigns = new Set<Campaign>([SELECT Name, Id FROM Campaign WHERE Campaign.Name = :leadSourceStrings]);
            for (Lead l : Trigger.new) {
                if (campaigns.size() < leadSourceStrings.size() ) {
                    l.addError('Please select an existing campaign source');
                }
            }

        }
        if(Trigger.isUpdate) {
            List<String> leadSources = new List<String>();
            for (Lead l : Trigger.new){
                leadSources.add(l.LeadSource);
            }
            Set<String> leadSourceStrings = new Set<String>();
            leadSourceStrings.addAll(leadSources);
            Set<Campaign> campaigns = new Set<Campaign>([SELECT Campaign.Name, Id FROM Campaign WHERE Campaign.Name = :leadSourceStrings]);
            for (Lead l : Trigger.new) {
                if (campaigns.size() < leadSourceStrings.size()) {
                    l.addError('Please select an existing campaign source');
                }
            }
        }
    }else{
        if(Trigger.isInsert || Trigger.isUpdate){
            List<CampaignMember> campaignMembers =new List<CampaignMember>();
            List<String> leadSources = new List<String>();
            Map<Lead,Date> dates = new Map<Lead,Date>();
            for (Lead l : Trigger.new){
                leadSources.add(l.LeadSource);
                dates.put(l, l.CreatedDate.date());
            }
            Set<String> leadSourceStrings = new Set<String>();
            leadSourceStrings.addAll(leadSources);

            Map<Id,Campaign> parentCampaigns = new Map<Id,Campaign>([SELECT Name, Id FROM Campaign WHERE Name=:leadSourceStrings]);

            List<Campaign> realChildCampaigns =[SELECT Name, Id, Parent.Name, StartDate, EndDate FROM Campaign WHERE ParentId =:parentCampaigns.keySet()];


            for(Lead l :Trigger.new){
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
    }
}