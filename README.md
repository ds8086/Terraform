# F5 Big-IP Terraform Examples
This is the sum of all my tinkering with F5 Big-IP configurations managed via Terraform. While delving into the topic, I explored using both the "native" Terraform provider for creation and management of LTM objects as well as using Terraform to apply AS3 JSON configurations. Both methodologies have their pros and cons. The "native" provider, for example, *provides* no support for the F5 GTM module which means you are forced to decouple the LTM object configuration from the related GTM objects. GTM objects for the application would be managed out-of-band either manually, via invoked SSH/TMSH commands, for through another platform such as Ansible. Using AS3 *does* provide support for the F5 GTM module, however it completely lacks the expected behavior of "correcting" out-of-band changes to objects once an AS3 configuration has been applied. This means that should an object be created via an AS3 configuration applied via Terraform, then the object is subsequently changed in the F5 through the configuration utility, running a `terraform plan` will show that no changes need to take place. The configuration drift is only "corrected" once the AS3 Terraform configuration is changed in some way which forces the entire AS3 configuration to be reapplied. I plan on putting together a very detailed white paper on using the native Terraform provider to manage LTM objects versus using Terraform to apply AS3 configurations. Look for that in the near future.

## f5-bigip\apps

#### as3_example
A working example of applying an AS3 configuration via Terraform. Three different virtual server and pool configurations are created each of which uses the same two nodes for load balancing. Each configuration references the `f5-bigip\modules\as3` module and then utilizes different JSON templates depending on the configuration. JSON templates for GTM exist as file names prepended with `_gtm`. As mentioned in the intro, this is currently the only way to manage GTM via Terraform.

My AS3 example is largely based upon the [medium-f5-terraform-vault repo by Maniak Academy](https://github.com/maniak-academy/medium-f5-terraform-vault).

#### ltm_example
A working example of managing LTM objects using the native Terraform provider *without* AS3. All modules *other* than the `f5-bigip\modules\as3` are referenced. The `nodes`, `cert`, and `irules` modules act as unique configurations since they can only be created once, but can be reused across multiple virtual server configurations, which means each of these modules produces output which is ingested by other modules.

## f5-bigip\modules
| Name      | Description                                               | Output    |
| :-------- | :-------------------------------------------------------- | :-------- |
| as3       | AS3 configs. Contains `json` directory with templates.    | FALSE     |
| cert      | Client and server SSL profiles, certificates, and keys.   | TRUE      |
| http      | HTTP virtual server template and related LTM objects.     | FALSE     |
| https     | HTTPS virtual server template and related LTM objects.    | FALSE     |
| irules    | iRules.                                                   | TRUE      |
| nodes     | Nodes.                                                    | TRUE      |
| tcp       | TCP virtual server teamplte and related LTM objects.      | FALSE     |
| udp       | UDP virtual server teamplte and related LTM objects.      | FALSE     |

## Useful Links
- [F5 BIG-IP Terraform Provider](https://registry.terraform.io/providers/F5Networks/bigip/latest/docs)
- [Big-IP AS3 User Guide](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/)