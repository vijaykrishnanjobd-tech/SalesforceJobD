import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/lwcController.getAccounts';


const COLUMNS=[
    {label:'Name', fieldName:'Name', type:'text'},
    {label:'Industry', fieldName: 'Industry', type:'text'},
    {label:'Phone', fieldName: 'Phone', type:'phone'},
    {label: 'Total Contacts', fieldName:'Total_Contacts__c', type:'number' },

];

export default class AccountList extends LightningElement{

    accounts=[];
    COLUMNS = COLUMNS;
    isLoading = true;
    error;

    @wire(getAccounts)
    wiredAccounts({data, error}){
        if(data){
            this.accounts=data;
            console.log('VJ: '+JSON.stringify(data, null, 2));
            this.isLoading = false;
        }

        if(error){
            this.error=error.body.message;
            console.error(error);
            this.isLoading = false;
        }
        
    }
    

}