const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "onboardnigAPIAlfa": {
                    "endpointType": "REST",
                    "endpoint": "https://kdwyum7514.execute-api.us-east-1.amazonaws.com/staging",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "userDataInitAlfa": {
                    "endpointType": "REST",
                    "endpoint": "https://pgd16vksdi.execute-api.us-east-1.amazonaws.com/staging",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "alfaUpdateLastStopped": {
                    "endpointType": "REST",
                    "endpoint": "https://rgplgrwgj9.execute-api.us-east-1.amazonaws.com/staging",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "getLecturesOrder": {
                    "endpointType": "REST",
                    "endpoint": "https://y886xbf9g1.execute-api.us-east-1.amazonaws.com/staging",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "getUserLecturesAlfa": {
                    "endpointType": "REST",
                    "endpoint": "https://q8i8fevvt2.execute-api.us-east-1.amazonaws.com/staging",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "getLecturesAlfa": {
                    "endpointType": "REST",
                    "endpoint": "https://t6u3urwy88.execute-api.us-east-1.amazonaws.com/staging",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:5008d6fe-e663-4657-a3be-4a027e4be7a0",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_pgJI2UbhT",
                        "AppClientId": "1mtdbrt6liblql16jg4pfg7fal",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": [
                                "REQUIRES_LOWERCASE",
                                "REQUIRES_NUMBERS",
                                "REQUIRES_SYMBOLS",
                                "REQUIRES_UPPERCASE"
                            ]
                        },
                        "signupAttributes": [
                            "ADDRESS",
                            "BIRTHDATE",
                            "EMAIL",
                            "FAMILY_NAME",
                            "GIVEN_NAME",
                            "PHONE_NUMBER"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                }
            }
        }
    }
}''';