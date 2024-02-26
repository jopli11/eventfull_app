const admin = require("firebase-admin/app");
admin.initializeApp();

const getCityFromCoordinate = require("./get_city_from_coordinate.js");
exports.getCityFromCoordinate = getCityFromCoordinate.getCityFromCoordinate;
