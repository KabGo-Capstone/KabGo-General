// import passport from 'passport';
// import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';
// import { Strategy as GoogleStrategy } from 'passport-google-oauth20';
// import { Strategy as FacebookStrategy } from 'passport-facebook';
// import { Strategy as GithubStrategy } from 'passport-github';
// import { Request } from 'express';
// import UserModel from './models/user.model';

// const cookieExtractor = (req: Request): string | null => {
//     let token = null;
//     if (req && req.cookies) {
//         token = req.cookies['jwt']
//     }
//     return token;
// }

// const jwtOptions = {
//     jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
//     secretOrKey: process.env.JWT_SECRET as string,
//     passReqToCallback: true
// }

// const jwtStrategy = new JwtStrategy(jwtOptions, (req: Request, jwt_payload: any, done: any) => {
//     UserModel.findOne({_id: jwt_payload._id}).then((user) => {
//         if (user) {
//             req.user = user;
//             return done(null, user)
//         } else {
//             if (jwt_payload.verification_code) { // if user create new account, and request verify their otp code
//                 req.verification_code = jwt_payload.verification_code;
//                 return done(null, jwt_payload.verification_code);
//             }
//             else return done(null, false)
//         }
//     }).catch(err => {
//         done(err, false);
//     });
// })

// const googleStrategy = new GoogleStrategy({
//      // options for Google Strategy
//      clientID: process.env.CLIENT_ID_GOOGLE as string,
//      clientSecret: process.env.CLIENT_SECRET_GOOGLE as string,
//      callbackURL: "/v1/auth/google/cb",
//      proxy: true
//     }, async (accessToken: string, refreshToken: string, profile: any, done) => {    // Check if user already exists in our database
//     let user = await UserModel.findOne({googleID: profile.id})
//     if (!user) {
//         user = await UserModel.create({
//             googleID: profile.id,
//             username: profile.displayName,
//             password : '',
//             email: profile.emails[0].value,
//             lastname: profile.name.familyName,
//             firstname: profile.name.givenName,
//             avatar: profile.photos[0].value,
//         })
//     }
//     done(null, user);
// })

// const facebookStrategy = new FacebookStrategy({
//     clientID: process.env.CLIENT_ID_FACEBOOK as string,
//     clientSecret: process.env.CLIENT_SECRET_FACEBOOK as string,
//     callbackURL: "/v1/auth/facebook/cb",
//     profileFields: ['id', 'name', 'emails', 'displayName', 'about', 'gender', 'photos'],
//     proxy: true
// }, async (accessToken: string, refreshToken: string, profile: any, done) => {
//     let user = await UserModel.findOne({facebookID: profile.id})
//     if (!user) {
//         user = await UserModel.create({
//             facebookID: profile.id,
//             username: profile.displayName,
//             password : '',
//             avatar: "https://graph.facebook.com/" + profile.id + "/picture" + "?width=200&height=200",
//             facebookId: profile.id,
//             lastname: profile.name.familyName,
//             firstname: profile.name.givenName,
//             email: profile.emails[0].value
//         })
//     }
//     done(null, user)
// })

// const githubStrategy = new GithubStrategy({
//     clientID: process.env.CLIENT_ID_GITHUB as string,
//     clientSecret: process.env.CLIENT_SECRET_GITHUB as string,
//     callbackURL: "/v1/auth/github/cb",
// }, async (accessToken: string, refreshToken: string, profile: any, done) => {
//     // Check if user already exists in our database
//     let user = await UserModel.findOne({githubID: profile.id})
//     if (!user) {
//         user = await UserModel.create({
//             githubID: profile.id,
//             username: profile.username,
//             password : '',
//             email: profile.emails[0].value,
//             firstname: profile.displayName,
//             avatar: profile.photos[0].value,
//         })
//     }
//     done(null, user);
// })

// passport.use(jwtStrategy);
// passport.use(googleStrategy);
// passport.use(facebookStrategy);
// passport.use(githubStrategy);

// export default passport;
