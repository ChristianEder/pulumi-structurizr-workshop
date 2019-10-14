import { Container } from 'structurizr-typescript';
import * as azure from '@pulumi/azure';
import { Shop } from '../shop';
import { ProductDatabase } from './productDatabase';
import { PaymentProviderIntegration } from './paymentProviderIntegration';

export class Website {

    public container: Container;
    public infrastructure: {
        plan: azure.appservice.Plan,
        app: azure.appservice.AppService
    };

    constructor(shop: Shop, productDatabase: ProductDatabase, paymentProviderIntegration: PaymentProviderIntegration) {
        // Define architecture
        this.container = shop.system.addContainer('Website', 'Lets users buy stuff', 'Shopware hosted on Azure')!;
        this.container.uses(productDatabase.container, 'Load product data, save customer orders');
        this.container.uses(paymentProviderIntegration.container, 'fulfill payments');
        shop.customer.uses(this.container, 'buy stuff');
        
        // Define infrastructure
        const plan = new azure.appservice.Plan('website', {
            resourceGroupName: shop.resourceGroup.name,
            kind: 'App',
            sku: {
                tier: 'Free',
                size: 'F1'
            }
        });

        const app = new azure.appservice.AppService('website', {
            resourceGroupName: shop.resourceGroup.name,
            appServicePlanId: plan.id,
            appSettings: {
                'PRODUCTS_CONNECTION_STRING': productDatabase.infrastructure.account.primaryConnectionString,
                'PRODUCTS_TABLE_NAME': productDatabase.infrastructure.products.name,
                'PAYMENTS_TABLE_NAME': productDatabase.infrastructure.payments.name,
                'PAYMENTS_CONNECTION_STRING': paymentProviderIntegration.infrastructure.storage.primaryConnectionString,
                'PAYMENTS_QUEUE_NAME': paymentProviderIntegration.infrastructure.queue.name
            }
        });

        this.infrastructure = { plan, app };
    }
}