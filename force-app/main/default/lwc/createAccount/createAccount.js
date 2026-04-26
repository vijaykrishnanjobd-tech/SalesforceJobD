import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent"

import NAME from '@salesforce/schema/Account.Name';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import PHONE from '@salesforce/schema/Account.Phone';

export default class createAccount extends LightningElement{

FIELDS = [NAME, INDUSTRY, PHONE];

handleSuccess(event){
    this.dispatchEvent(
        new ShowToastEvent({
            title: "Success",
            message:"Account Successfully Created",
            variant: "success"
        })
    );
}

handleError(event){
    this.dispatchEvent(
        new ShowToastEvent({
            title: "Error",
            message: "Account Creation Failed: " + event.detial.message,
            variant: "error"
        })
    );
}
}