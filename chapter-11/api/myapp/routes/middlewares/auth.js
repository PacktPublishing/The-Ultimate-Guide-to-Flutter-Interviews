var jwt = require("jsonwebtoken");
const secretKey = "your_secret_key";

// Middleware para validar o token JWT em todas as rotas protegidas

  verifyJWT= async (req, res, next) => {
    try {
      const bearerHeader = req.headers["authorization"];
      const bearer = bearerHeader.split(" ");
      const bearerToken = bearer[1];
      var decoded = jwt.verify(bearerToken, "test-key", function (err, data) {
        console.log(bearerToken)

        if (!err) {
            next();

        } 
      });

      
    } catch (e) {
      console.log(e)
        res.status(401).json({
            erro: "You have not permissions",
          });
    }
  },
module.exports ={ verifyJWT};
