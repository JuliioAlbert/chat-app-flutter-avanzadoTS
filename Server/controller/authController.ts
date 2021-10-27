import { Request, Response } from 'express';
import { Usuario } from '../models/Ususario';
import { compareSync, genSaltSync, hashSync} from 'bcrypt';
import JWT from '../helpers/jwt';

interface IAuth{
     crearUsuario: Function,
     loginUsuario:Function,
     renewToken:Function,
}

export class AuthController implements IAuth {
    
    
    public crearUsuario = async (req: Request, res: Response) => {

        const { email,password  } = req.body;
    
        try {
            const usuarioDb = await Usuario.findOne({ email });
            if (usuarioDb) {
                return res.status(400).json({
                    ok:false,
                    msj: "Ya existe usuario"
                })
            }
    
            const usuario = new Usuario(req.body);
    
            const salt =  genSaltSync()
    
            usuario.password =  hashSync(password,salt);
    
    
            await usuario.save();
    
            ///Generar Token
            const token = await JWT.generarJWT(usuario.id)
    
            res.json({
                ok: true,
                usuario,
                token
            });
    
    
        } catch (error) {
            return res.status(500).json({
                ok:false,
                msj: "Error del Server"
            });
        }
    }
    
    public loginUsuario = async (req:Request, res:Response) => {
       
       const {email, password} = req.body;
       
        try {
            const usuarioDB = await Usuario.findOne({email});
            if(!usuarioDB){
                return res.status(404).json({
                    ok:false,
                    msj:"Usuario Not Found"
                });
            }

            const validPassword= compareSync(password, usuarioDB.password);
            if(!validPassword ){
                return res.status(400).json({
                    ok:false,
                    msj:"Password not machets"
                });
            }

            ///Generar JWT
            const token = await JWT.generarJWT(usuarioDB.id);



            res.json({
                ok: true,
                usuarioDB,
                token
            });
        } catch (error) {
           return res.status(500).json({
               ok:false,
               msj: "Error del Server"
           });
        }
    }

    public renewToken = async(req:Request, res:Response) => {
        const id = (req as any).uid as string;
        const token = await JWT.generarJWT(id);

        const usuario = await Usuario.findById(id);

      
        return res.json({
            ok:true,
            usuario,
            token
        })
    };


    
} 






