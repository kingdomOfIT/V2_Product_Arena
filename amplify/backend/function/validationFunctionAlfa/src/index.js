exports.handler = (event, context, callback) => {
    // Extract the birth date from the event data
    const birthdate = event.request.userAttributes.birthdate;
    
    // Define the expected birth date format
    const dateFormat = /^\d{2}-\d{2}-\d{4}$/;
    
    // Check if the birth date matches the expected format
    if (!birthdate.match(dateFormat)) {
      // Return an error if the birth date format is invalid
      return callback(new Error("Invalid birth date format. Expected DD--MM-YYYY."));
    }
    
    // Continue with the sign-up process if the birth date format is valid
    return callback(null, event);
  };
  