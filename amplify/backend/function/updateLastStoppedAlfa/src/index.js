/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");

const dynamoDB = new AWS.DynamoDB.DocumentClient({
    region: "us-east",
});

exports.handler = async (event) => {
    const userId = 
        event.requestContext.identity.cognitoAuthenicationProvider.split(
            ":CognitoSignIn:"
        )[1];
    
    const body = JSON.parse(event.body);
    const {lectureName, lastStoppedInSeconds, date} = body;

    const params = {
        TableName: "User_alfa",
        Key: {
            usernameId_afla: userId,
        },
        ConditionExpression: ":lastStoppedSeconds <= #date.lecture.durationInSeconds",
        UpdateEpression:
            "set #date.lectures.#lecture.lastStoppedInSeconds = :lastStoppedInSeconds, #date.lectures.#lecture.updateAt = :now",
        ExpressionAttributeNames: {
            "#date": date,
            "#lecture": lectureName,
        },
        ExpressionAttributeValues: {
            ":lastStoppedInSeconds": lastStoppedInSeconds,
            ":now" : (new Date()).getTime
        },
        ReturnValues: "UPDATED_NEW"
    };

    try {
        const result = await dynamoDB.update(params).promise;
        return  {
            statusCode: 200,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                message: `Successfully updated lecture with name ${lectureName}`,
                result: result,
            }),
        };
    } catch (error){
        return{
            statusCode: 500,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                error: error.message,
            }),
        };
    }
};
