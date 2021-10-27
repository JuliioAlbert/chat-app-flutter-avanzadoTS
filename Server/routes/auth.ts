/*
/api/login/

*/

import Router from 'express';
import { check } from 'express-validator';
import { AuthController } from '../controller/authController';
import { validarCampos } from '../middleware/validar-campos';
import { validarJWT } from '../middleware/validarJWT';




export class AuthRoute {
    
}

const router = Router();

const authController:AuthController = new AuthController();


router.post('/new', [
    check('nombre', "Argument name is required").not().isEmpty(),
    check('email', "Argument email is required").isEmail(),
    check('password', "Argument password is required").not().isEmpty().isLength({min:6}).withMessage("Not lengt"),
    validarCampos
] ,authController.crearUsuario);


router.post('/', [
    check('email', "Argument email is required").isEmail(),
    check('password', "Argument password is required").not().isEmpty().isLength({min:6}).withMessage("Not lengt"),
    validarCampos
] ,authController.loginUsuario);

// validarJWT
router.get('/renew', validarJWT ,authController.renewToken);

export default router;

