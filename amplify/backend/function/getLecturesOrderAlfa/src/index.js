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
  try {
    const data = await dynamoDb
      .get({
        TableName: "RoleLectures_alfa",
        Key: {
          startdate: date,
        },
      })
      .promise();
    let lectures = data.Item;
    delete lectures.startdate;
    let resp = {};
    for (let key in lectures) {
      let map = {};
      lectures[key].forEach((el) => {
        map[el.name] = el.index;
      });
      resp[key.slice(0, -8)] = map;
    }
    console.log(resp);
    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({ lectureOrders: resp }),
    };
  } catch (err) {
    return {
      statusCode: 500,
      //  Uncomment below to enable CORS requests
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        err,
        info: "Lectures with given date not found",
      }),
    };
  }
};
