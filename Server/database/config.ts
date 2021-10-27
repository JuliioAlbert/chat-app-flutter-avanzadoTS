import mongoose from 'mongoose';


export const dbConnect = async() =>{
    try {
        await mongoose.connect(process.env.DBCONNECT as string);
        console.log("DBOnline");
    } catch (error) {
        throw new Error("Error al connectar")
    }
}