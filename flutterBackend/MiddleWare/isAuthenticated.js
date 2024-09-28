import jwt from "jsonwebtoken";
import { user } from "../Model/userModel.js";

export const isAuthenticated = async (req, res, next) => {
  try {
    // Extract the token from the Authorization header
    const authHeader = req.headers["authorization"];

    // Check if Authorization header is present and starts with "Bearer"
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({ message: "User not authenticated" });
    }

    // Extract the token (remove "Bearer " part)
    const token = authHeader.split(" ")[1];
      console.log(token)
    console.log("Token from Flutter:", token);

    // Verify the token
    const decode = await jwt.verify(token, process.env.JWT_SECRET);

    if (!decode) {
      return res.status(401).json({ message: "Invalid token" });
    }

    // Attach user ID to the request object
    req.id = decode.userId;

    next();
  } catch (error) {
    console.log("Authentication Error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

export const isAdmin = async (req, res, next) => {
  try {
    const token = req.cookies.token;

    if (!token) {
      return res.status(401).json({ message: "user not authenticated" });
    }

    const decode = await jwt.verify(token, process.env.JWT_SECRET);
    if (!decode) {
      return res.status(401).json({ message: "Invalid token" });
    }
    req.id = decode.userId;

    const userDetails = await user.findById(decode.userId);
    if (!userDetails) {
      return res
        .status(404)
        .json({ message: "User not found", success: false });
    }

    if (userDetails.role != "admin") {
      return res
        .status(401)
        .json({ message: "Access denied user not authenticated" });
    }

    next();
  } catch (error) {
    console.log(error);
  }
};
