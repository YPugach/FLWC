import { LightningElement, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { reduceErrors } from 'c/ldsUtils';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import FIRSTNAME_FIELD from '@salesforce/schema/Lead.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Lead.LastName';
import EMAIL_FIELD from '@salesforce/schema/Lead.Email';
import COMPANY_FIELD from '@salesforce/schema/Lead.Company';
import insertLeads from '@salesforce/apex/createLeadLWC.insertLead';


export default class CreatingLeads extends LightningElement {

//     @track leadId;
     @track leadList = [{
         Id: '',
         firstName: '',
         lastName : '',
         email: ''
     }];
     count=0;

     handleFirstNameChange(event) {
        this.leadId = undefined;
        this.firstName = event.target.value;
     }
     handleLastNameChange(event) {
         this.leadId = undefined;
         this.lastName = event.target.value;
     }
     handleEmailChange(event) {
         this.leadId = undefined;
         this.email = event.target.value;
     }

     addItem(){
         console.log('Hello');

         this.leadList.push ({
             Id: '',
             firstName: '',
             lastName : '',
             email: ''
         });

         console.log(this.leadList);
     }


     createLead(event) {
         insertLeads({
                 amount: this.amount,
                 stage: 'Closed Won'
             })
             .then(() => {
                 return refreshApex(this.opptiesOverAmount);
             })
             .catch((error) => {
                 this.message = 'Error received: code' + error.errorCode + ', ' +
                     'message ' + error.body.message;
             });
         }










//     createLead() {
//        const fields = {};
//        fields[FIRSTNAME_FIELD.fieldApiName] = this.firstName;
//        fields[LASTNAME_FIELD.fieldApiName] = this.lastName;
//        fields[EMAIL_FIELD.fieldApiName] = this.email;
//        fields[COMPANY_FIELD.fieldApiName] = this.lastName;
//        const recordInput = { apiName: LEAD_OBJECT.objectApiName, fields };
//        createRecord(recordInput)
//            .then( lead => {
//                this.leadId = lead.id;
//                this.dispatchEvent(
//                    new ShowToastEvent({
//                        title: 'Success',
//                        message: 'Lead created',
//                        variant: 'success',
//                    }),
//                );
//            })
//            .catch(error => {
//                this.dispatchEvent(
//                    new ShowToastEvent({
//                        title: 'Error creating record',
//                        message: reduceErrors(error).join(', '),
//                        variant: 'error',
//                    }),
//                );
//            });
//    }

}