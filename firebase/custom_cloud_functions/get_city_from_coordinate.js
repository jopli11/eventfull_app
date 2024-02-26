const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios"); // Ensure axios is included in your dependencies

// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.getCityFromCoordinate = functions
  .region("europe-west3")
  .runWith({
    memory: "128MB",
  })
  .https.onCall(async (data, context) => {
    // Extract latitude and longitude from the data parameter
    const { latitude, longitude } = data;

    // Access the API key stored in Firebase environment configuration
    const apiKey = functions.config().googlemaps.key;

    // Construct the URL for the Geocoding API request
    const url = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${apiKey}`;

    try {
      // Make the API request
      const response = await axios.get(url);

      // Parse the response to extract the city name
      // Ensure that your response includes address components
      const city = response.data.results[0].address_components.find(
        (component) => component.types.includes("locality"),
      ).long_name;

      // Return the city name
      return { city };
    } catch (error) {
      // Handle any errors that occur during the API request
      console.error("Error fetching city name:", error);
      throw new functions.https.HttpsError(
        "unknown",
        "Failed to fetch city name",
        error,
      );
    }
  });
