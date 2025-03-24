import bind_gen_json_schema_validator.com.networknt.schema;
import bind_gen_json_schema_validator.java.lang;
import bind_gen_json_schema_validator.java.util;

import ballerina/io;

public function validate(json jsonValue, string schemaPath) returns error? {
    json schemaJson = check io:fileReadJson(schemaPath);
    schema:VersionFlag versionFlag = schema:VersionFlag_getV7();
    schema:JsonSchema jsonSchema = schema:JsonSchemaFactory_getInstance(versionFlag)
            .getSchema10(schemaJson.toJsonString());
    util:Set|error validationResults = trap jsonSchema.validate11(jsonValue.toJsonString(), schema:InputFormat_getJSON());
    if (validationResults is error) {
        return error("Unexpected error occurred while validating the JSON: " + validationResults.message());
    }

    if validationResults.size() == 0 {
        return ();
    }

    string stringResult = "";
    util:Iterator iterator = validationResults.iterator();
    while iterator.hasNext() {
        lang:Object next = iterator.next();
        stringResult += next.toString() + "\n";
    }

    return error("Following error(s) occurred while validating the JSON: \n" + stringResult);
}

