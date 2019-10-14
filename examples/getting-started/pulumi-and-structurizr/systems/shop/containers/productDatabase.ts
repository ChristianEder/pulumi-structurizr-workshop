import { Container } from 'structurizr-typescript';
import { Shop } from '../shop';
import * as azure from '@pulumi/azure';

export class ProductDatabase {

    public container: Container;
    public infrastructure: {
        account: azure.storage.Account,
        products: azure.storage.Table,
        payments: azure.storage.Table
    };

    constructor(shop: Shop) {
        // Define architecture
        this.container = shop.system.addContainer('Database', 'stores available products and customer orders', 'SQL Database')!;

        // Define infrastructure
        const account = new azure.storage.Account('product', {
            resourceGroupName: shop.resourceGroup.name,
            accountTier: 'Standard',
            accountReplicationType: 'LRS'
        })

        const products = new azure.storage.Table('products', {
            resourceGroupName: shop.resourceGroup.name,
            name: 'products',
            storageAccountName: account.name
        });

        const payments = new azure.storage.Table('payments', {
            resourceGroupName: shop.resourceGroup.name,
            name: 'payments',
            storageAccountName: account.name
        });

        this.infrastructure = { account, products, payments };
    }
}