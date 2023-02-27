/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
 
function isValidDateBefore2010(date) {
    const pattern = /^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-(19[0-9][0-9]|20[0-9][0-9])$/;
    if (!pattern.test(date)) {
      return false;
    }
  
    const [day, month, year] = date.split("-").map(Number);
    if (year >= 2010) {
      return false;
    }
  
    if (month < 1 || month > 12) {
      return false;
    }
  
    const maxDays = new Date(year, month, 0).getDate();
    if (day < 1 || day > maxDays) {
      return false;
    }
  
    return true;
  }
  
  function containsNumbers(name) {
    const pattern = /\d/;
    return pattern.test(name);
  }
  
  exports.handler = async (event, context, callback) => {
      console.log(`EVENT: ${JSON.stringify(event)}`);
      
      const birthdate = event.request.userAttributes.birthdate;
      if (!isValidDateBefore2010(birthdate)) {
      return callback
      ( new Error("Invalid birthdate.") );
      }
      
      
      const givenName = event.request.userAttributes.given_name;
      if (containsNumbers(givenName)) {
          return callback(new Error("First Name cannot contain numbers.")); 
        }
        
      const familyName = event.request.userAttributes.family_name;
      if (containsNumbers(familyName)) {
          return callback(new Error("Last name cannot contain numbers.")); 
      }
      
      const phoneNumber = event.request.userAttributes.phone_number;
      const phoneNumberRegex = /^\+\d{9,}$/;
      const isValidPhoneNumber = phoneNumberRegex.test(phoneNumber);
      if(!isValidPhoneNumber) {
          return callback( new Error("Phone number should contain at least 9 digits.")) 
      }
      
      const status = event.request.userAttributes['custom:status'];
      if(!["Student","Employed","Unemployed"].includes(status)){
          return callback(new Error("Invalid input for status."))
      }
      
      callback(null, event)
  };