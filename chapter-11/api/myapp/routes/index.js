var express = require("express");
var router = express.Router();
var jwt = require("jsonwebtoken");

/* GET home page. */
router.get("/", function (req, res, next) {
  res.render("index", { title: "Packt" });
});
router.post("/login", async function (req, res, next) {
  try {
    let { email, password } = req.body;
    var user = db.get("oto");
    if (user.email == email && user.password == password) {
      var token = jwt.sign({ foo: "bar" }, "test-key");
      res.json({ token: token });
      return;
    }
    throw Exception()
  } catch (e) {
    res.status(401).json('invalid credentials')
  }
});

module.exports = router;
