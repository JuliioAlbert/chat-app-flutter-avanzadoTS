import jwt from 'jsonwebtoken';

export interface IPayload{
    uid:string;
}


export default class JWT {

    static generarJWT(uid:string){
        return new Promise((resolve, reject) => {
            const payload:IPayload = { uid  }
    
            jwt.sign(payload, process.env.JWT_KEY as string, {
                expiresIn: '24hr' 
            }, (error, token) => {
                if(error){
                   reject("No se pudo generar el JWT")
                }else{
                    resolve(token);                    
                }
            });
        });
    }

}