export default {
  VITE_SERVER_HOST: import.meta.env.VITE_SERVER_HOST,
  VITE_OAUTH_REDIRECT_HOSTNAME:
    import.meta.env.VITE_OAUTH_REDIRECT_HOSTNAME ?? "https://www.watchparty.me",
  // No login in this private fork: leaving this empty unlocks every feature
  VITE_FIREBASE_CONFIG: import.meta.env.VITE_FIREBASE_CONFIG ?? "",
  VITE_FIREBASE_SIGNIN_METHODS: "facebook,google,email",
  NODE_ENV: import.meta.env.DEV ? "development" : "production",
};
