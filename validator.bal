import jsonschema.validator.schema;
import ballerina/io;

public function validate(json jsonValue, string schemaPath) returns error? {
   json schemaJson = check io:fileReadJson(schemaPath);

   // Define the default value of the schema version flag.
   // If the schema version is not explicitly specified, the default value is used.
   schema:VersionFlag versionFlag = schema:VersionFlag_getV202012();
   schema:JsonSchema jsonSchema = schema:JsonSchemaFactory_getInstance(versionFlag)
           .getSchema10(schemaJson.toJsonString());
   schema:Set|error validationResults = trap jsonSchema.validate11(jsonValue.toJsonString(), schema:InputFormat_getJSON());

   if validationResults is error {
       return error("Unexpected error occurred while validating the JSON value: " + validationResults.message());
   }

   if validationResults.size() == 0 {
       return ();
   }

   string stringResult = "";
   schema:Iterator iterator = validationResults.iterator();
   while iterator.hasNext() {
       schema:Object next = iterator.next();
       stringResult += next.toString() + "\n";
   }
   return error("Error(s) occurred while validating the JSON value: " + stringResult);
}
