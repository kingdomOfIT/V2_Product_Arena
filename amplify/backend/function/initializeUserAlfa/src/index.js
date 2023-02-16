/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const util = require("util");
const AWS = require("aws-sdk");
const dynamoDb = new AWS.DynamoDB.DocumentClient({
  region: "us-east-1",
});

exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  console.log('EVENT: ', util.inspect(event, { showHidden: false, depth: null }));

  let body = JSON.parse(event.body);
  console.log(body);
  let roles = body.roles;
  roles = roles.map((role) => `${role}Lectures`);
  let projection = roles.join(" , ");

  let lectures;
  try {
    const data = await dynamoDb
      .query({
        TableName: "RoleLectures_alfa",
        KeyConditionExpression: "startdate = :date",
        ExpressionAttributeValues: {
          ":date": body.date,
        },
        ProjectionExpression: projection,
      })
      .promise();
    lectures = data.Items[0];

    console.log(lectures);
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
        info: "can't find lectures with given date",
      }),
    };
  }
  let questions;
  try {
    let data = await dynamoDb
      .query({
        TableName: "onboardnigT",
        KeyConditionExpression: "startdate = :date",
        ExpressionAttributeValues: {
          ":date": body.date,
        },
      })
      .promise();
    console.log(data);
    questions = data.Items[0].questions;
  } catch (err) {
    console.log(err);
    return {
      statusCode: 400,
      //  Uncomment below to enable CORS requests
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        err,
        info: "form not found",
      }),
    };
  }

  // Combine lectures from every role selected without duplicates
  let lecturesCombined = [];
  for (let key in lectures) {
    lecturesCombined = [...lecturesCombined, ...lectures[key]];
  }
  // Collect. data and Save user
  const joinedArray = lecturesCombined.reduce((acc, curr) => {
    const found = acc.find((item) => item.name === curr.name);
    if (!found) {
      acc.push(curr);
    }
    return acc;
  }, []);
  console.log(joinedArray);
  // const userLectures = joinedArray.map((item) => {
  //   lectureName = item.name
  //   delete item.name
  //   return {
  //     `${lectureName}`: { ...item, lastStoppedInSeconds: 0 },
  //   };
  // });
  let userLectures = joinedArray.reduce((acc, curr, i) => {
    acc[curr.name] = curr;
    return acc;
  }, {});
  // check answer validity
  const answers = body.answers;
  let questionAnswers;
  try {
    questionAnswers = questions.map((item, i) => {
      if (!item.choices) {
        return {
          ...item,
          answer: answers[i],
        };
      }
      if (!item.choices.includes(answers[i])) {
        throw new Error("Invalid answer");
      }
      return {
        ...item,
        answer: answers[i],
      };
    });
  } catch (err) {
    return {
      statusCode: 400,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({
        err: "Invalid answer, must be from given choices",
      }),
    };
  }

  const record = {
    usernameId: event.requestContext.identity.cognitoAuthenticationProvider
      .split(":")
      .slice(-1)[0],
    lectures: userLectures,
    onboarding: questionAnswers,
    paDate: body.date,
  };

  try {
    // Save the record to the table
    await dynamoDb
      .put({
        TableName: "User_alfa",
        Item: record,
      })
      .promise();
    console.log("Record saved to DynamoDB");
    return {
      statusCode: 201,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({ record }),
    };
  } catch (error) {
    console.error(`Error saving record to DynamoDB: ${error}`);
    return {
      statusCode: 500,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
      },
      body: JSON.stringify({ error }),
    };
  }
};