"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.io = void 0;
const express_1 = __importDefault(require("express"));
const dotenv = __importStar(require("dotenv"));
const http_1 = require("http");
const path_1 = __importDefault(require("path"));
const Server = require("socket.io");
const config_1 = require("./database/config");
dotenv.config();
(0, config_1.dbConnect)();
const app = (0, express_1.default)();
const httpServer = (0, http_1.createServer)(app);
///Lectura y parseo de Body JSON
app.use(express_1.default.json());
///Sockets
exports.io = new Server(httpServer, { /* options */});
require("./sockets/socket");
const auth_1 = __importDefault(require("./routes/auth"));
//Path Publica
const publicPath = path_1.default.resolve(__dirname, 'public');
app.use(express_1.default.static(publicPath));
///Routes
app.use("/api/login", auth_1.default);
httpServer.listen(process.env.PORT, () => {
    console.log(`Corriendo en el puerto ${process.env.PORT}`);
});
//# sourceMappingURL=index.js.map