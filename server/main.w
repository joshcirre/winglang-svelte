bring cloud;
bring util;
bring http;
bring ex;
bring math;

let api = new cloud.Api({
    cors: true,
    corsOptions: {
        allowHeaders: ["*"],
        allowMethods: [http.HttpMethod.POST, http.HttpMethod.GET, http.HttpMethod.OPTIONS],
    }
});

let counter = new cloud.Counter();

api.get("/api/getcount", inflight (req) => {
    let count = counter.peek();
    return cloud.ApiResponse {
        body: Json.stringify(count),
        status: 200
    };
});

api.get("/api/counter", inflight (req) => {
    counter.inc();
    let count = counter.peek();
    return cloud.ApiResponse {
        body: Json.stringify(count),
        status: 200
    };
});

api.get("/api/random", inflight (req) => {
// let count = random number between 1 and 1000
let count = math.round(math.random(1000));

counter.set(count);

return cloud.ApiResponse {
   body: Json.stringify(count),
   status: 200
  };
});

api.get("/api/reset", inflight (req) => {
    counter.set(0);

    let count = 0;
    return cloud.ApiResponse {
        body: Json.stringify(count),
        status: 200
        };
});

let website = new ex.ReactApp(
  projectPath: "../client",
  localPort: 5173,
  buildDir: "/dist",
  startCommand: "npm run dev",
);


website.addEnvironment("APP_SERVER_URL",  api.url );
website.addEnvironment("fromServer",  "Hi there, I'm from the server." );
