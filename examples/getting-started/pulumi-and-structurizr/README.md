# Putting it together - architecture and infrastructure as code

This lab is intended for advanced users - i.e. developers that are already familiar with either structurizr or pulumi, ideally both.

It is intended to showcase how architecture and infrastructure as code can be combined in order to prevent creating a model code gap between the architectural intention and the actual code & infrastructure.

## Prerequisites

Please refer to the prerequisites sections for the [structurizr](../structurizr/README.md) and [pulumi](../pulumi/README.md) labs

## Lab tasks

### 01 - Get familiar with the code

The example code provided in [index.ts](index.ts) and its dependencies is building upon the same 'webshop' example that is also used in the [structurizr lab](../structurizr/README.md). 

But in this lab, the code - both the architectural as well as the infrastructure code - is refactored into seperate classes. Each container (in the sense of Simon Browns [C4 model](https://c4model.com)) is a separate class, containing both the code describing the containers architecture and its infrastructure.

Start by diving into the classes created from the code in [index.ts](index.ts) and try to understand whats happening there.

### 02 - Extend the webshop solution

You can try extending the webshop using the same extension ideas provided in the [structurizr lab](../structurizr/README.md#02---customize-the-architecture-model)

## Cheatsheet

- How to visualize the architecture model I created?
  > npm run architecture
  - open the newly generated file `out/architecture.puml` in VS Code
  - Press F1
  - Select `PlantUML: Preview Current Diagram`
  - Navigate throught the different sections of the `out/architecture.puml` file
- How to deploy the infrastructure to my cloud environment?
  > npm run infrastructure