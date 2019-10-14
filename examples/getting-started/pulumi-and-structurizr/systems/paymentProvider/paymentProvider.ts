import { Workspace, Location, SoftwareSystem, Person } from 'structurizr-typescript';

export class PaymentProvider {
    public system: SoftwareSystem;

    constructor(workspace: Workspace, customer: Person) {
        this.system = workspace.model.addSoftwareSystem('Payment Provider', 'Online payment provider')!;
        this.system.location = Location.External;
        
        customer.uses(this.system, 'pay for stuff');
    }
};