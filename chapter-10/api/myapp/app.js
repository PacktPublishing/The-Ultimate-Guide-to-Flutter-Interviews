var createError = require("http-errors");
var express = require("express");
var path = require("path");
const { dirname } = require("path");

var cookieParser = require("cookie-parser");
var logger = require("morgan");
const NodeCache = require("node-cache");

var indexRouter = require("./routes/index");
var usersRouter = require("./routes/books");
const appDir = dirname(require.main.filename);

var app = express();
var Dirty = require('dirty');
  global.db = new Dirty('user.db');

  db.on('load', function() {

    db.set("oto", { email:'oto@mail.com',password:'123456'});



    db.forEach(function(key, val) {
      console.log('Found key: %s, val: %j', key, val);
    });
  });

  db.on('drain', function() {
    console.log('All records are saved on disk now.');
  });

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

app.use("/", indexRouter);
app.use("/books", usersRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {

  next(createError(404));
});


// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development

  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

module.exports = app;
