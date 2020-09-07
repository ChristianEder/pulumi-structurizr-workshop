import { Container } from 'structurizr-typescript';
import * as azure from '@pulumi/azure';
import { Shop } from '../shop';
import { PaymentProvider } from '../../paymentProvider/paymentProvider';
import { ProductDatabase } from './productDatabase';

export class PaymentProviderIntegration {

    public container: Container;
    public infrastructure: {
        storage: azure.storage.Account,
        queue: azure.storage.Queue,
        processPaymentFunction: azure.storage.QueueFunction,
        functionApp: azure.appservice.MultiCallbackFunctionApp
    };

    constructor(shop: Shop, paymentProvider: PaymentProvider, productDatabase: ProductDatabase) {
        // Define architecture
        this.container = shop.system.addContainer('Payment integration', 'Manages integration of the payment provider', 'Azure function calling out to PayPal')!;
        this.container.uses(paymentProvider.system, 'fulfil payments');
        this.container.uses(productDatabase.container, 'mark orders as paid');

        // Define infrastructure
        const storage = new azure.storage.Account('payment', {
            resourceGroupName: shop.resourceGroup.name,
            accountReplicationType: 'LRS',
            accountTier: 'Standard',
        });

        const queue = new azure.storage.Queue('payments', {
            storageAccountName: storage.name,
        });

        const processPaymentFunction = queue.getEventFunction('process-payment',
            {
                outputs: [productDatabase.infrastructure.payments.output('processedPayments')],
                callback: async (context, msg) => {
                    // - Call PayPal API here
                    // - Store result into the processedPayments output
                    // This code here is not only mixing architecture & infrastructure code,
                    // It also throws production code (that will actually be executed at runtime)
                    // into the mix. This is done by harnessing some pulumi magic that will
                    // serialize the code of this callback, and deploy it together with all its
                    // dependencies to the created function app - after wiring the functions input
                    // and output bindings to the input queue and output table as defined above.
                    // If you do not want to mix infrastructure & productive code in this way,
                    // you can either move this function into a separate file (or even another package)
                    // and just import it here, or you can refactor the infrastructure definition
                    // to setup only the infrastructure (e.g. just the FunctionApp, without functions)
                    // and deploy your function by other means to that infrastructure
                }
            }
        );

        const functionApp = new azure.appservice.MultiCallbackFunctionApp('process-payment', {
            resourceGroupName: shop.resourceGroup.name,
            functions: [processPaymentFunction]
        });

        this.infrastructure = { storage, queue, processPaymentFunction, functionApp };
    }
}