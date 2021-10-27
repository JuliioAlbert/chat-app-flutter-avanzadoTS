"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
class JWT {
    static generarJWT(uid) {
        return new Promise((resolve, reject) => {
            const payload = { uid };
            jsonwebtoken_1.default.sign(payload, process.env.JWT_KEY, {
                expiresIn: '24hr'
            }, (error, token) => {
                if (error) {
                    reject("No se pudo generar el JWT");
                }
                else {
                    resolve(token);
                }
            });
        });
    }
}
exports.default = JWT;
//# sourceMappingURL=jwt.js.map