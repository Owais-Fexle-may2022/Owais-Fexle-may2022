import { LightningElement } from 'lwc';
import getTextMethod1 from '@salesforce/apex/Controller.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/Controller.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/Controller.getTextMethod3';


export default class RenderMultipleTemplate extends LightningElement {
    message1;
    message2;
    message3;
    handleClickMe1() {
        getTextMethod1()
            .then(result1 => {
                this.message1 = result1;
            })
            .catch(error => {
                this.error=error;
            });
    }

    handleClickMe2() {
        getTextMethod1()
            .then(result1 => {
                this.message1 = result1;
            })
        getTextMethod2()
            .then(result2 => {
                this.message2 =result2;
            })
            .catch(error => {
                this.error=error;
            });
    }

    handleClickMe3() {
        getTextMethod1()
            .then(result1 => {
                this.message1 = result1;
            })
        getTextMethod2()
            .then(result2 => {
                this.message2 =result2;
            })
        getTextMethod3()
            .then(result3 => {
                this.message3 = result3;
            })
            .catch(error => {
                this.error=error;
            });
    }        
}