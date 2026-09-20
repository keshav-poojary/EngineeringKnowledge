const express = require("express");
const cluster = require("cluster");
const os = require('os')

let cpus = os.cpus().length;

if(cluster.isPrimary){
    console.log(`iam primary process, ${process.pid}`)
    for(let i =0;i<cpus;i++){
        cluster.fork();
    }
    cluster.on("exit", (worker)=>{
        console.log(`Worker ${worker.process.pid} got exited or died`);
        cluster.fork();
    })
}else{
    const app = express();
    app.get("/", (req,res)=>{
        res.json({
            message: 'Hello from nodejs app',
            data: `${process.pid}`
        })
    })
    app.listen(3000,()=>{
        console.log(`App server running on PORT, ${process.pid}`)
    })
}

