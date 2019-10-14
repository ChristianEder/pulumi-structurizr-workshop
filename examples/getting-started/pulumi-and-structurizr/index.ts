import { Workspace, PlantUMLWriter } from 'structurizr-typescript'
import { PaymentProvider } from './systems/paymentProvider/paymentProvider';
import { Shop } from './systems/shop/shop';
import * as fs from 'fs';

const workspace = new Workspace();
workspace.name = 'Your workspace name';

const customer = workspace.model.addPerson('Customer', 'uses the shop to buy stuff')!;
const paymentProvider = new PaymentProvider(workspace, customer);
const shop = new Shop(workspace, paymentProvider, customer);

const UPDATE_ARCHITECTURE = process.env.UPDATE_ARCHITECTURE && process.env.UPDATE_ARCHITECTURE.toString() === 'true'
if(UPDATE_ARCHITECTURE){
    const plantUmlExport = new Promise((resolve, reject) => {
        const plantUML = new PlantUMLWriter().toPlantUML(workspace);
        fs.writeFile('out\\architecure.puml', plantUML, e => {
            if(e){
                reject(e);
            }
            resolve();
        });
    });
    plantUmlExport.then(() => {
        console.log('done');
    }).catch(e => {
        console.log('error', e);
    });
}