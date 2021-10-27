"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const Ususario_1 = require("../models/Ususario");
const bcrypt_1 = require("bcrypt");
const jwt_1 = __importDefault(require("../helpers/jwt"));
class AuthController {
    constructor() {
        this.crearUsuario = (req, res) => __awaiter(this, void 0, void 0, function* () {
            const { email, password } = req.body;
            try {
                const usuarioDb = yield Ususario_1.Usuario.findOne({ email });
                if (usuarioDb) {
                    return res.status(400).json({
                        ok: false,
                        msj: "Ya existe usuario"
                    });
                }
                const usuario = new Ususario_1.Usuario(req.body);
                const salt = (0, bcrypt_1.genSaltSync)();
                usuario.password = (0, bcrypt_1.hashSync)(password, salt);
                yield usuario.save();
                ///Generar Token
                const token = yield jwt_1.default.generarJWT(usuario.id);
                res.json({
                    ok: true,
                    usuario,
                    token
                });
            }
            catch (error) {
                return res.status(500).json({
                    ok: false,
                    msj: "Error del Server"
                });
            }
        });
        this.loginUsuario = (req, res) => __awaiter(this, void 0, void 0, function* () {
            const { email, password } = req.body;
            try {
                const usuarioDB = yield Ususario_1.Usuario.findOne({ email });
                if (!usuarioDB) {
                    return res.status(404).json({
                        ok: false,
                        msj: "Usuario Not Found"
                    });
                }
                const validPassword = (0, bcrypt_1.compareSync)(password, usuarioDB.password);
                if (!validPassword) {
                    return res.status(400).json({
                        ok: false,
                        msj: "Password not machets"
                    });
                }
                ///Generar JWT
                const token = yield jwt_1.default.generarJWT(usuarioDB.id);
                res.json({
                    ok: true,
                    usuarioDB,
                    token
                });
            }
            catch (error) {
                return res.status(500).json({
                    ok: false,
                    msj: "Error del Server"
                });
            }
        });
        this.renewToken = (req, res) => __awaiter(this, void 0, void 0, function* () {
            const id = req.uid;
            const token = yield jwt_1.default.generarJWT(id);
            const usuario = yield Ususario_1.Usuario.findById(id);
            return res.json({
                ok: true,
                usuario,
                token
            });
        });
    }
}
exports.AuthController = AuthController;
//# sourceMappingURL=authController.js.map