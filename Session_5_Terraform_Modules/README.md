## Notes

1. **What are the differences between `var` and `local`?**

### Key Differences

**Purpose**:
- **Variables (`var`)**: Used for input parameters to your modules, making the configurations customizable and reusable with different inputs.
- **Locals (`local`)**: Used to define reusable expressions or values within a module to avoid repetition and simplify configuration logic.

**Scope**:
- **Variables (`var`)**: Can be passed from outside the module, either through command line arguments, environment variables, or files.
- **Locals (`local`)**: Limited to the module they are defined in and not configurable from outside.

**Usage Context**:
- **Variables (`var`)**: Ideal for parameters that need to be set differently in different environments or by different users.
- **Locals (`local`)**: Ideal for intermediate values or expressions that are used multiple times within a module, ensuring that complex expressions are defined once and reused.

**Flexibility**:
- **Variables (`var`)**: More flexible as they allow external input, making the module highly reusable and configurable.
- **Locals (`local`)**: More about code simplification and readability within the module itself.

2. **Why do I get Warning: EC2 Default Network ACL (acl-014deabdd7ddd9655) not deleted, removing from state?**

   - **Default Network ACLs in AWS**: Every VPC in AWS has a default network ACL that cannot be deleted. When you create a VPC, AWS automatically creates a default network ACL associated with it.
   
   - **Terraform State Management**: Terraform manages infrastructure resources through its state file. If it attempts to delete a resource that cannot be deleted (such as a default network ACL), it will log a warning and remove the resource from the state file to avoid inconsistencies.
   
   Generally, you can ignore this warning because it's a standard behavior due to AWS restrictions. Terraform is just informing you that it won't manage the default network ACL anymore but will continue to manage other resources.