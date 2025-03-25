# Ballerina JSON Schema Validator  

A lightweight Ballerina library for validating JSON values against **JSON Schema** (Draft 4+).

### Key Features  
✔ **Validate JSON** against schemas programmatically.  
✔ **Supports Draft 4+** schemas (with `$id` and modern keywords).  
✔ **Simple API** – Pass JSON + schema, get validation results.  
✔ **Error Reporting** – Detailed validation failures with paths.  

```ballerina  
import sasindu/jsonschema.validator as validator;  

json payload = { "name": "Ballerina", "version": "2201.7.0" };  
json schema = {  
    type: "object",  
    properties: {  
        name: { type: "string" },  
        version: { type: "string" }  
    }  
};  

error? result = validator:validate(payload, schema);  
if result is error {  
    // Handle validation failure
}  
```  
