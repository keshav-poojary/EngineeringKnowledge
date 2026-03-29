const express = require('express');
const { Worker } = require ('worker_threads');
const heapdump = require('heapdump');

// Save a snapshot manually
heapdump.writeSnapshot('./' + Date.now() + '.heapsnapshot');

console.log('Heap snapshot written!');

const app = express();
const worker = new Worker('./worker');

app.get('/non-blocking',(req, res)=>{
  res.json({ data: 'Im non blocking data'})
})

app.get('/blocking',(req,res)=>{
    worker.on("message",(count)=>{
         res.json({ data: count})
    })
    worker.on("error",(error)=>{
        res.json({error})
    })
})

app.listen(3000,()=>{
    console.log(`app listening`)
})