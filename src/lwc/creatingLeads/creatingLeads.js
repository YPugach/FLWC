import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { reduceErrors } from 'c/ldsUtils';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import FIRSTNAME_FIELD from '@salesforce/schema/Lead.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Lead.LastName';
import EMAIL_FIELD from '@salesforce/schema/Lead.Email';
import COMPANY_FIELD from '@salesforce/schema/Lead.Company';

export default class CreatingLeads extends LightningElement {
    greeting = 'Lead';

    @track leadId;
     firstName = '';
     lastName = '';
     email = '';
     company = '';


     handleFirstNameChange(event) {
        this.firstName = event.target.value;
     }
     handleLastNameChange(event) {
         this.accountId = undefined;
         this.lastName = event.target.value;
     }
     handleEmailChange(event) {
         this.email = event.target.value;
     }
     createLead() {
        const fields = {};
        fields[FIRSTNAME_FIELD.fieldApiName] = this.firstName;
        fields[LASTNAME_FIELD.fieldApiName] = this.lastName;
        fields[EMAIL_FIELD.fieldApiName] = this.email;
        fields[COMPANY_FIELD.fieldApiName] = this.lastName;
        const recordInput = { apiName: LEAD_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(account => {
                this.leadId = lead.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Lead created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
}