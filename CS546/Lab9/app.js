/*****
 * Author: Jennifer Cafiero
 * Date: November 20, 2017
 * CS546 Lab 9 - A Simple User Login System
 * I pledge my honor that I have abided by the Stevens Honor System
 *****/

 const express = require("express");
 const exphbs = require("express-handlebars");
 const session = require("express-session");
 const bodyParser = require("body-parser");
 const passport = require("passport");
 const configRoutes = require("./routes");
 const cookieParser = require("cookie-parser");
 const cookieSession = require("cookie-session");
 const flash = require("connect-flash");
 const app = express();


app.use(express.static('/public'));
app.use(session({
	secret: "secret"
}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(passport.initialize());
app.use(passport.session());
app.use(cookieParser('secret'));
app.use(flash());

app.engine('handlebars', exphbs({}));
app.set('view engine', 'handlebars');

 configRoutes(app);

 app.listen(3000, () => {
 	console.log("We've now got a server!");
 	console.log("Your routes will be running on http://localhost:3000");
 });