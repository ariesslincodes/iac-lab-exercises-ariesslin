## Notes

1. **What are the differences between `var` and `local`?**

### Key Differences

1. **Purpose**:
   - **Variables (`var`)**: Used for input parameters to your modules, making the configurations customizable and reusable with different inputs.
   - **Locals (`local`)**: Used to define reusable expressions or values within a module to avoid repetition and simplify configuration logic.

2. **Scope**:
   - **Variables (`var`)**: Can be passed from outside the module, either through command line arguments, environment variables, or files.
   - **Locals (`local`)**: Limited to the module they are defined in and not configurable from outside.

3. **Usage Context**:
   - **Variables (`var`)**: Ideal for parameters that need to be set differently in different environments or by different users.
   - **Locals (`local`)**: Ideal for intermediate values or expressions that are used multiple times within a module, ensuring that complex expressions are defined once and reused.

4. **Flexibility**:
   - **Variables (`var`)**: More flexible as they allow external input, making the module highly reusable and configurable.
   - **Locals (`local`)**: More about code simplification and readability within the module itself.