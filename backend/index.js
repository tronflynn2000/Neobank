//Here I'll initiate a server in order to build the backend of this neobank
//app of mine.

import express from "express";

const app = express();
const puerto = 3000;

app.get("/about", (req,res)=> {
    res.send("<h1>About Me</h1>");
});

app.get("/", (req, res) =>{
    res.send("<h1> Hello World<h1/>");
});

app.listen(3000, () => {
    console.log("Server running on port ", puerto);
});