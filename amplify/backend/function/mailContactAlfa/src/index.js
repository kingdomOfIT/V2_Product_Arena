/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");

AWS.config.update({ region: 'us-east-1' });

const cognitoClient = new AWS.CognitoIdentityServiceProvider({
    region: "us-east-1",
  });

exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);
    let cognitoAuthenticationProvider =
    event.requestContext.identity.cognitoAuthenticationProvider;
    let splitProvider = cognitoAuthenticationProvider.split(":");
    console.log("split array", splitProvider);

    const user = await cognitoClient
    .adminGetUser({
      UserPoolId: "us-east-1_pgJI2UbhT",
      Username: splitProvider[splitProvider.length - 1],
    })
    .promise();
    console.log("user", user);

    const question = JSON.parse(event.body).question;
    const recipient = 'amir.intec@gmail.com';

    let email = user.UserAttributes.find( el => el.Name === "email")
    const userEmailAddress = email.Value

    const params = {
        Destination: {
            ToAddresses: [recipient]
        },
        Message: {
            Body: {
                Text: {
                    Data: question
                }
            },
            Subject: {
                Data: 'Product Arena Question'
            }
        },
        Source: 'amir.intec@gmail.com',
        ReplyToAddresses: [userEmailAddress]
    };

    const sendPromise = new AWS.SES({ apiVersion: '2010-12-01'}).sendEmail(params).promise();

    await sendPromise;
    return {
        statusCode: 200,
        body: JSON.stringify({
            success:"Question sent to product arena support center"
        })
    }
};
