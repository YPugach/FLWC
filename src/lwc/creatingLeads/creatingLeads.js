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
import insertLead from '@salesforce/apex/createLeadLWC.insertLead';


export default class CreatingLeads extends LightningElement {
     lastId = 0;
     @track leadId;
     @track leadList = [{
         Id: this.lastId,
         firstName: '',
         lastName : '',
         email: '',
         company:'test'
     }];
     addItem(){
         this.lastId = this.lastId + 1 ;
         this.leadList.push ({
             Id: this.lastId,
             firstName: '',
             lastName : '',
             email: '',
             company: 'test'
         });
         console.log(this.leadList);
         console.log(this.leadList.length);
         console.log('and');
     }

     handleChange(event) {
         var foundElement = this.leadList.find( item => item.Id == event.target.dataset.id);
         foundElement[event.target.name] = event.target.value;
         this.leadList = [...this.leadList];
         console.log(this.leadList);
         console.table(JSON.stringify(this.leadList));
         console.log(this.leadList);
     }

     createLead(event) {
         console.log(this.leadList);
         var arrNewLead=[];
         var arrOldLead = this.leadList.slice();

         for(var i=0; i<arrOldLead.length; i=i+1){
             var obj = Object.assign({},arrOldLead[i]);
             delete obj.Id;
             arrNewLead.push(obj);
         };

         for(var i=0; i<arrNewLead.length; i=i+1){
             var obj = Object.assign({},arrNewLead[i]);
             for (var key in obj){
                 if (obj[key] == ''){
                    this.dispatchEvent(
                       new ShowToastEvent({
                           title: 'Error creating record',
                           message: 'Please fill in the blank fields',
                           variant: 'error'
                       })
                    );
                 return;
                 }
                 if (key == 'email'&&  /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(obj[key]) != true){
                    this.dispatchEvent(
                       new ShowToastEvent({
                           title: 'Error creating record',
                           message: 'Please enter a valid email',
                           variant: 'error'
                       })
                    );
                 return;
                 }
             }
         }
         console.log(arrNewLead);
         var jsonData = JSON.stringify(arrNewLead);
         console.log(jsonData);
         insertLead({jsonString: jsonData});
         this.dispatchEvent(
             new ShowToastEvent({
                 title: 'Success',
                 message: 'Leads created',
                 variant: 'success'
             })
         );
     }
}