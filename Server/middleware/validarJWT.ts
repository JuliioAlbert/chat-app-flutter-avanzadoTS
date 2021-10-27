import  { verify } from 'jsonwebtoken';
import { NextFunction, Request, Response } from "express";
import { IPayload } from '../helpers/jwt';

export const validarJWT = (req:any ,res:Response, next:NextFunction) => {
    const token = req.header("x-token");
    
    if(!token){
        return res.status(401).json({
            ok:false,
            msj:"No authorize"
        })
    }
   try {
       const {uid}  =  verify(token, process.env.JWT_KEY as string) as IPayload;
       req.uid = uid;
       next();
   } catch (error) {
    return res.status(401).json({
        ok:false,
        msj:"No authorize"
    })

   }

    
}