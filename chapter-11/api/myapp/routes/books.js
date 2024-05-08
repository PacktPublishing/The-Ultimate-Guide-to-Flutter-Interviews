const { cache } = require("ejs");
var express = require("express");
const { json } = require("express/lib/response");
var router = express.Router();
const admin = require("../routes/middlewares/auth");

/* GET users listing. */
router.get("/", function (req, res, next) {
  try {
    var listBooks = db.get("books");
    if (listBooks) {
      res.json(listBooks);
      return;
    }
    throw Exception();
  } catch (error) {
    res.status(204).json();
  }
});
router.post("/", admin.verifyJWT, function (req, res, next) {
  var { book_name } = req.body;
  try {
    console.log(req)
    var newId =1
    var listBooks = db.get("books");
    console.log(listBooks)
    if(listBooks != undefined){
      var newId = listBooks["books"].length + 1;
        }else{
      listBooks = ({books:[]})
    }
    listBooks["books"].push({ id: newId, name: book_name });
    db.set("books", listBooks);
    res.status(201).json(listBooks["books"]);

  } catch (error) {
    console.log(error)
  }
});
router.put("/1", admin.verifyJWT, function (req, res, next) {

  res.json({success:"updated"});
});
router.delete("/1", admin.verifyJWT, function (req, res, next) {
  res.json({success:'deleted' });
});
module.exports = router;
