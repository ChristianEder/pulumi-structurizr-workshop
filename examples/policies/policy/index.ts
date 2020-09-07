import * as azure from "@pulumi/azure";
import { PolicyPack, StackValidationArgs, ReportViolation } from "@pulumi/policy";

export const policies = new PolicyPack("example-policy", {
    policies: [
        {
            name: "example-policy",
            description: "All function apps must use a consumption plan",
            enforcementLevel: "advisory",
            validateStack: (args: StackValidationArgs, reportViolation: ReportViolation) => {
                const servicePlans = args.resources.map(r => r.asType(azure.appservice.Plan)).filter(r => r);

                servicePlans.forEach(plan => {
                    if(plan?.sku.tier !== 'Dynamic' || plan.sku.size !== 'Y1'){
                        reportViolation('All function apps must use consumptions plans with \'Dynamic\' tier and \'Y1\' size.', plan?.id);
                    }
                });
            }
        }
    ],
});
