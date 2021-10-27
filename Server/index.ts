
import express from "express";
import * as dotenv from 'dotenv';
import { createServer } from "http";
import path from 'path';
import Server = require("socket.io");

import { dbConnect } from "./database/config";

dotenv.config();

dbConnect();




const app = express();
const httpServer = createServer(app);

///Lectura y parseo de Body JSON
app.use(express.json())

///Sockets
export const io = new Server(httpServer, { /* options */ });
import "./sockets/socket";
import Auth from './routes/auth';





//Path Publica
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));

///Routes

app.use("/api/login", Auth);



httpServer.listen(process.env.PORT, () => {
    console.log(`Corriendo en el puerto ${process.env.PORT}`);
});



