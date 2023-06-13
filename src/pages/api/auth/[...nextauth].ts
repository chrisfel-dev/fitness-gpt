import NextAuth from "next-auth";
import { authOptions } from "fitness-gpt/server/auth";

export default NextAuth(authOptions);
