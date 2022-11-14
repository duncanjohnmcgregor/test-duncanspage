#  Terraform Scratch for Strap*
## TODO
* Global variables for project and region instead of separate variables.tf in app/networking
* CloudBuild pipeline / triggers

## Objective
Define baseli*ne terraform structure that will later be created by strap

## Current Structure

```cmd
    deployments
    ├───shared_data.tf
    ├───provider.tf
    ├───networking
    │   ├───variables.tf
    │   ├───terraform.tfvars
    │   └───dev
    │       ├───main.tf
    │       ├───outputs.tf
    │       ├───backend.tf
    │       ├───provider.tf         (sym -> ..\..\)
    │       ├───variables.tf        (sym -> ..\)
    │       └───terraform.tfvars    (sym -> ..\)    
```



## Logical Tf Structure

### Networking
X-env networking structure
Manages VPC and other networking components

### Application
Deploys applications into the networking VPCs


## Strap will need to
* Update shared_data.tf and each backend.tf prefix with appropriate project names
* When creating backend.tf, make sure the environment element of the prefix is set correctly 
* Update terraform.tfvars host project for each env
* Execute tf init, tf plan, tf apply to setup first
