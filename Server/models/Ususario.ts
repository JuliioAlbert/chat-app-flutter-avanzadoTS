import { model, Schema } from 'mongoose';
import { IUsuario } from '../interfaces/IUsuario';




const UsuarioSchema:Schema<IUsuario> = new Schema<IUsuario>({
    nombre: {
        type:String,
        required:true,
    },
    email: {
        type:String,
        required:true,
        unique: true,
    },
    password: {
        type:String,
        required:true,
    },
    online: {
        type: Boolean,
        default:false,
    },
});
UsuarioSchema.method("toJSON", function(){
    const {__v, _id, password,...objetc} = this.toObject();
    objetc.uid = _id;
    return objetc;
})

export const Usuario = model<IUsuario>('User', UsuarioSchema);

