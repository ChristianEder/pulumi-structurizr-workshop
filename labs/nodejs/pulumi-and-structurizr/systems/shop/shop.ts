import { Workspace, Location, SoftwareSystem, Person } from 'structurizr-typescript';
import { PaymentProvider } from '../paymentProvider/paymentProvider';
import * as azure from '@pulumi/azure';
import { ProductDatabase } from './containers/productDatabase';
import { PaymentProviderIntegration } from './containers/paymentProviderIntegration';
import { Website } from './containers/website';

export class Shop {
    public system!: SoftwareSystem;
    public resourceGroup!: azure.core.ResourceGroup;
    private productDatabase!: ProductDatabase;
    private paymentProviderIntegration!: PaymentProviderIntegration;
    private website!: Website;

    constructor(workspace: Workspace, paymentProvider: PaymentProvider, public customer: Person) {
        this.defineSystemLevel(workspace, paymentProvider);
        this.defineContainerLevel(paymentProvider);
        this.defineViews(workspace);
    }

    private defineSystemLevel(workspace: Workspace, paymentProvider: PaymentProvider){
        // Define architecture
        this.system = workspace.model.addSoftwareSystem('Shop', 'Online shopping system')!;
        this.system.location = Location.Internal;
        this.system.uses(paymentProvider.system, 'process customer payments');
        this.customer.uses(this.system, 'buy stuff');
        
        // Define infrastructure
        this.resourceGroup = new azure.core.ResourceGroup('shop', {
            location: azure.Locations.WestEurope
        });
    }

    private defineContainerLevel(paymentProvider: PaymentProvider){
        this.productDatabase = new ProductDatabase(this);
        this.paymentProviderIntegration = new PaymentProviderIntegration(this, paymentProvider, this.productDatabase);
        this.website = new Website(this, this.productDatabase, this.paymentProviderIntegration);
    }

    private defineViews(workspace: Workspace) {
        const systemContext = workspace.views.createSystemContextView(this.system, 'shop-context', 'The system context view for the shop');
        systemContext.addNearestNeighbours(this.system);
       
        const containerView = workspace.views.createContainerView(this.system, 'shop-containers', 'Container view for the shop');
        containerView.addAllContainers();
        containerView.addNearestNeighbours(this.system);
    }
};