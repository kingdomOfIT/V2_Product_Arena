/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");

AWS.config.update({ region: 'us-east-1' });

const cognitoISP = new AWS.CognitoIdentityServiceProvider({
    region: "us-east-1",
  });

exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);
    let cognitoAuthenticationProvider =
    event.requestContext.identity.cognitoAuthenticationProvider;
    let splitProvider = cognitoAuthenticationProvider.split(":");
    console.log("split array", splitProvider);

    const user = await cognitoISP
    .adminGetUser({
      UserPoolId: "us-east-1_pgJI2UbhT",
      Username: splitProvider[splitProvider.length - 1],
    })
    .promise();
    console.log("user", user);

    const params = {
        AccessToken: user
    };

    cognitoISP.getUser(params, function(err, data) {
        if (err) {
          console.log(err, err.stack);
        } else {
          // Log the user's name, surname, and email
          console.log('Name: ' + data.UserAttributes.find(attr => attr.Name === 'given_name').Value);
          console.log('Surname: ' + data.UserAttributes.find(attr => attr.Name === 'family_name').Value);
          console.log('Email: ' + data.UserAttributes.find(attr => attr.Name === 'email').Value);
        }
      });

};
