/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");
const dynamoDb = new AWS.DynamoDB.DocumentClient({
  region: "us-east-1",
});

exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  const date = event.queryStringParameters.paDate;
  const lectureName = event.queryStringParameters.name; // maybe
  if (!date) {
    return {
      statusCode: 400,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        error: "paDate is required as query parameter",
      }),
    };
  }
  const userId =
    event.requestContext.identity.cognitoAuthenticationProvider.split(
      ":CognitoSignIn:"
    )[1];

  try {
  let params = {
      TableName: "User_alfa",
      KeyConditionExpression: "usernameId_alfa = :userId",
      ExpressionAttributeValues: {
        ":userId": userId,
      },
      ProjectionExpression: `#date.lectures`,
      ExpressionAttributeNames: {
        "#date": date
      }
    }
    if(lectureName){
      params.ProjectionExpression = `#date.lectures.#name`;
      params.ExpressionAttributeNames = { 
        "#name" : lectureName,
        '#date' : date
      }
    }
    const data = await dynamoDb
      .query(params)
      .promise();
    console.log(data);
    // if (date !== data.Items[0].paDate) {
    //   return {
    //     statusCode: 400,
    //     headers: {
    //       "Access-Control-Allow-Origin": "*",
    //       "Access-Control-Allow-Headers": "*",
    //     },
    //     body: JSON.stringify({
    //       error: "user not assigned to paDate",
    //     }),
    //   };
    // }
    if(data.Count === 0) { 
      return { 
        statusCode: 404,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "*",
        },
        body: JSON.stringify({ error: "User lectures not found. Submit the onboarding form."}), 
      };
    }
    const lectures = data.Items[0][date].lectures;
    console.log(lectures)
    let arrayversion = Object.values(lectures)
    arrayversion.sort(function(a, b) {
      return b.updatedAt - a.updatedAt;
    });
    console.log(JSON.stringify({
      lectures: arrayversion
    }))
    // console.log("wut",Object.values(lectures))
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
      //  Uncomment below to enable CORS requests
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        err, 
        message: err.message
      }),
    };
  }
};
