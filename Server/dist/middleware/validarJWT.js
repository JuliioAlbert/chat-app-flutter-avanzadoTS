"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validarJWT = void 0;
const jsonwebtoken_1 = require("jsonwebtoken");
const validarJWT = (req, res, next) => {
    const token = req.header("x-token");
    if (!token) {
        return res.status(401).json({
            ok: false,
            msj: "No authorize"
        });
    }
    try {
        const { uid } = (0, jsonwebtoken_1.verify)(token, process.env.JWT_KEY);
        req.uid = uid;
        next();
    }
    catch (error) {
        return res.status(401).json({
            ok: false,
            msj: "No authorize"
        });
    }
};
exports.validarJWT = validarJWT;
//# sourceMappingURL=validarJWT.js.map