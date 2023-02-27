/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
const AWS = require("aws-sdk");
const dynamoDb = new AWS.DynamoDB.DocumentClient({
    region: "us-east-1",
});
exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);
    let date = event.queryStringParameters.paDate; 
    let lecture_name = event.queryStringParameters.name; 
    if (!date) {
        return {
            statusCode: 400,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                error: "You need to provide paDate parameter",
            }),
        };
    }
    const user_id = event.requestContext.identity.cognitoAuthenticationProvider.split(
        ":CognitoSignIn:"
    )[1];
    try {
        let params = {
            TableName: "User_alfa",
            KeyConditionExpression: "usernameId_alfa = :user_id",
            ExpressionAttributeValues: {
                ":user_id": user_id,
            },
            ProjectionExpression: `#date.lectures`,
            ExpressionAttributeNames: {
                "#date": date
            }
        }
        if (lecture_name){
            params.ProjectionExpression = `#date.lectures.#name`;
            params.ExpressionAttributeNamesI = {
                "#name" : lecture_name,
                '#date' : date
            }
        }
        const data = await dynamoDb
            .query(params)
            .promise();
        console.log(data);
 
        if (data.Count === 0) {
            return {
                statusCode: 404,
                headers: {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Headers": "*",
                },
                body: JSON.stringify({ error: "User lectures not found. Submit the onbaording form."}),
            };
        }
        const lectures = data.Items[0][date].lectures;
        console.log(lectures);
        let arrayversion = Object.values(lectures)
        arrayversion.sort(function(a, b) {
            return b.updatedAt - a.updatedAt;
        });
        console.log(JSON.stringify({
            lectures: arrayversion
        }))
        
        return {
            statusCode: 200,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({ lectures: arrayversion}),
        };
    } catch (err) {
        console.log(err)
        return {
            statusCode: 500,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                err,
                info: err.message
            }),
        };
    }
}