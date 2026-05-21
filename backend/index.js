// Here I'll initiate a server in order to build the backend of this neobank
// app of mine.

import express from "express";
import crypto from "crypto";
import { Pool } from "pg";
import "dotenv/config"
import session from "express-session";
import passport from "passport";

const app = express();
const puerto = process.env.PORT;

app.use(express.json());
app.use(session({
    secret: "TOPSECRETWORD",
    resave: false,
    saveUninitialized: true,

})
);
app.use(passport.initialize());
app.use(passport.session());

const pool = new Pool({
    connectionString:
        process.env.DATABASE_URL
});

function hashPassword(password) {
    const salt = crypto.randomBytes(16).toString("hex");
    const derivedKey = crypto
        .pbkdf2Sync(password, salt, 310000, 32, "sha256")
        .toString("hex");
    return `${salt}:${derivedKey}`;
}

function verifyPassword(password, storedHash) {
    const [salt, key] = storedHash.split(":");
    const derivedKey = crypto
        .pbkdf2Sync(password, salt, 310000, 32, "sha256")
        .toString("hex");
    return crypto.timingSafeEqual(Buffer.from(key, "hex"), Buffer.from(derivedKey, "hex"));
}

app.get("/about", (req, res) => {
    res.send("<h1>About Me</h1>");
});

app.get("/", (req, res) => {
    res.send("<h1> Hello World</h1>");
});

//Here I'll define the login function in our API.
app.post("/login", async(req,res) =>{
    //Here we need to define the events that take place in order to login.
    const { username, password } = req.body;
    //Here we would need to check if the username meets the requirements.
    if (!username || !password){
        return res.status(401).json({
            error:  "name and password required",
        });
    }

    pwd_hash = await pool.query(
        "SELECT password_hash FROM public.client WHERE email = $1",
            [email]
    );

    if (pwd_hash.rows.length <= 0) {
            return res.status(409).json({
                error: "A user with that email does not exist",
            });
        }
    else if(verifyPassword(pwd_hash.rows[0], password)){
        return res.status(200).json;
    }

});

app.get("/secrets", (req,res) => {
    res.send("You are logged in!");
});

app.post("/register", async (req, res) => {
    const { name, surname, email, password, phone_number } = req.body;

    if (!name || !surname || !email || !password) {
        return res.status(400).json({
            error: "name, surname, email and password are required",
        });
    }

    try {
        const existing = await pool.query(
            "SELECT id FROM public.client WHERE email = $1",
            [email]
        );

        if (existing.rows.length > 0) {
            return res.status(409).json({
                error: "A user with that email already exists",
            });
        }

        const password_hash = hashPassword(password);
        const result = await pool.query(
            `INSERT INTO public.client
                (name, surname, email, password_hash, phone_number)
             VALUES ($1, $2, $3, $4, $5)
             RETURNING id, name, surname, email, phone_number, date_creation`,
            [name, surname, email, password_hash, phone_number || null]
        );

        return res.status(201).json({
            message: "User registered successfully",
            user: result.rows[0],
        });
    } catch (error) {
        console.error("Registration failed:", error);
        return res.status(500).json({
            error: "Unable to register user at this time",
        });
    }
});

app.listen(puerto, () => {
    console.log("Server running on port", puerto);
});