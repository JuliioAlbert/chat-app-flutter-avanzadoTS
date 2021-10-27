"use strict";
/*
/api/login/

*/
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthRoute = void 0;
const express_1 = __importDefault(require("express"));
const express_validator_1 = require("express-validator");
const authController_1 = require("../controller/authController");
const validar_campos_1 = require("../middleware/validar-campos");
const validarJWT_1 = require("../middleware/validarJWT");
class AuthRoute {
}
exports.AuthRoute = AuthRoute;
const router = (0, express_1.default)();
const authController = new authController_1.AuthController();
router.post('/new', [
    (0, express_validator_1.check)('nombre', "Argument name is required").not().isEmpty(),
    (0, express_validator_1.check)('email', "Argument email is required").isEmail(),
    (0, express_validator_1.check)('password', "Argument password is required").not().isEmpty().isLength({ min: 6 }).withMessage("Not lengt"),
    validar_campos_1.validarCampos
], authController.crearUsuario);
router.post('/', [
    (0, express_validator_1.check)('email', "Argument email is required").isEmail(),
    (0, express_validator_1.check)('password', "Argument password is required").not().isEmpty().isLength({ min: 6 }).withMessage("Not lengt"),
    validar_campos_1.validarCampos
], authController.loginUsuario);
// validarJWT
router.get('/renew', validarJWT_1.validarJWT, authController.renewToken);
exports.default = router;
//# sourceMappingURL=auth.js.map