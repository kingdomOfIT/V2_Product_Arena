/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");

const dynamoDB = new AWS.DynamoDB.DocumentClient({
  region: "us-east-1",
});

exports.handler = async (event) => {
  const userId = event.requestContext.identity.cognitoAuthenticationProvider.split(":CognitoSignIn:")[1];

  const body = JSON.parse(event.body);
  const { lectureName, videoFeedback, date } = body;
  
  const params = {
    TableName: "User_alfa",
    Key: {
      usernameId_alfa: userId,
    },
    //ConditionExpression: ":videoFeedback <= #date.lectures.#lecture.durationInSeconds",
    UpdateExpression:
      "set #date.lectures.#lecture.videoFeedback = :videoFeedback",
    ExpressionAttributeNames: {
      "#date": date,
      "#lecture": lectureName,
    },
    ExpressionAttributeValues: {
      ":videoFeedback": videoFeedback
    },
    ReturnValues: "UPDATED_NEW",
  };

  try {
    const result = await dynamoDB.update(params).promise();
    console.log(result);
    return {
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
  } catch (error) {
    console.log(error);
    return {
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
