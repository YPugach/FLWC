/**
 * Created by e.pugach on 28.02.20.
 */
public with sharing class CampaignWrapper implements Comparable{
    public Campaign camp;
    public Integer monthNumber;

    public CampaignWrapper (Campaign camp) {
        this.camp = camp;
        this.monthNumber = camp.StartDate.month();
    }

    public Integer compareTo(Object compareToMonth){
        CampaignWrapper compareToMonthNumber = (CampaignWrapper) compareToMonth;
        if (monthNumber == compareToMonthNumber.monthNumber) return 0;
        if (monthNumber > compareToMonthNumber.monthNumber) return 1;
        return -1;
    }
}